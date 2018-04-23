class Tranheads::Nobank < Tranhead


    attr_accessor :askoverdraw                      
    attr_accessor :overdraw                         # This and 1 above used to validate that bank account not overdrawn

    attr_accessor :allorig                          # This is HASH of the case_ids and the original values (Need to checking if overdrawing on the edit)
    attr_accessor :sumtramount                      # This is the original sum of all of the amounts  (Need for checking if balance<0 for client bank on the EDIT)
    attr_accessor :bankorig                         # This is the original bank account used
    attr_accessor :novalidation                     # When called from the office receipts then no valiation -- looked after there 

    validate :Check_Client_Balances 

    after_initialize do |init|
        if !self.new_record?
            if !self.allorig.nil?
                if self.sumtramount.nil?                    # called many times --- only want to do this first time (once)
                    _total=0
                    self.allorig=Hash.new                     # Initialize the HASH -- this is where all previous balances will be storred
                    self.trans.each do |tr|                                                     # Get the total for the current transaction
                        self.allorig[tr.case_id.to_int] = tr.tramount.abs
                        _total=_total+tr.tramount.abs
                    end
                    self.sumtramount=_total
                    self.bankorig=self.bank_id
                end
            end
        end
    end 

    def Check_Client_Balances
        if self.trans.first.type=='Trancpmat'
            self.trans.each do |tr|                                                     # Get the total for the current transaction
                tr.askclientoverdraw=false
                if !tr.case_id.nil?
                    if !tr.tramount.nil?
                        # Skip through the original HASH of values to get the original total for the case
                        torigsum=0
                        if !self.allorig.nil?
                            torigsum=self.allorig[tr.case_id]
                            if torigsum.nil?
                                torigsum=0
                            else
                               torigsum=torigsum.abs 
                            end
                        end
                        tclbal=Nomtran.where(case_id: tr.case_id, nomcode: 'CLIENT').sum(:amount)
                        if tclbal.nil?
                           tclbal=0 
                        end
                        tclbal=tclbal*-1
                        tnewbal=tclbal-tr.tramount.abs+torigsum
                        if tnewbal<0
                            if tr.clientoverdraw.nil? or tr.clientoverdraw=="0"
                                errors.add(:base, 'Case '+tr.case.reference+' Overdrawn - see below')
                                tr.errors.add(:base, 'This will overdraw the client account for '+tr.case.reference+'- click on "Overdraw this Case" and save again if you wish to continue anyway')
                                tr.askclientoverdraw=true
                            end
                        end
                    end             
                end
            end
        end
    end

end
