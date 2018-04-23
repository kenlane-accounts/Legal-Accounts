class Tranheads::Bankclient < Tranhead
    belongs_to :bank, -> {where(isclient: true)}, :class_name => 'Nominal'
    validates_presence_of :bank
    
    attr_accessor :askoverdraw                      
    attr_accessor :overdraw                         # This and 1 above used to validate that bank account not overdrawn

    attr_accessor :allorig                          # This is HASH of the case_ids and the original values (Need to checking if overdrawing on the edit)
    attr_accessor :sumtramount                      # This is the original sum of all of the amounts  (Need for checking if balance<0 for client bank on the EDIT)
    attr_accessor :bankorig                         # This is the original bank account used
    attr_accessor :novalidation                     # When called from the office receipts then no valiation -- looked after there 

    validate :Check_Balances 
    validate :Check_Client_Balances 
    validate :Check_Dup_Case

    after_initialize do |init|
        if !self.new_record?
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

    def Check_Balances
        if !self.novalidation                             # This is called from the client receipts screen also when transferring from client account
            self.askoverdraw=false
            if self.trans.first.type=='Trancpmat'
                if !self.bank_id.nil?
                    tbankbal=Nomtran.where('nominal_id='+self.bank_id.to_s).sum(:amount)        # Get exists balance
                    tbankbal=tbankbal
                    ttrantotal=0
                    self.trans.each do |tr|                                                     # Get the total for the current transaction
                        if !tr.tramount.nil?
                            ttrantotal=ttrantotal+tr.tramount.abs
                        end
                    end
    
                    # When checking make sure the bank hasnt changed --- only include previous balance if still on the same bank
                    if self.bank_id==self.bankorig
                       torigamt=self.sumtramount.to_d
                    else
                        torigamt=0
                    end
                    if tbankbal-ttrantotal+torigamt<0                              # Take current transaction overall total from bank balance to see if <0  (torigamt is original amount for the edit)
                        if self.overdraw.nil? or self.overdraw=="0"
                            errors.add(:base, 'Cannot save transaction, Insufficient funds in the Client Bank account : '+self.bank.code)
                            # If we want to give option to allow to continue we can by uncommenting the next line 
                            # self.askoverdraw=true
                        end
                    end
                    
                end 
            end
        end     
    end

    def Check_Client_Balances
        if !self.novalidation                                   # This is called from the client receipts screen also when transferring from client account
                                                                # Do not validate that here -- That will have an office bank account as the tranhead so only for client payment from client account here
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
                            tclbal=Nomtran.where(case_id: tr.case_id, nomcode: "CLIENT").sum(:amount)
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


    def Check_Dup_Case
        if !self.novalidation                                   # This is called from the client receipts screen also when transferring from client account
                                                                # Do not validate that here -- That will have an office bank account as the tranhead so only for client payment from client account here
            # Skip through each transaction and store the case_id and position 
            # Then skip through the transactions again to see if the same case id is in a different position
            self.trans.each_with_index do |tr, index|                                                     # Get the total for the current transaction
                if !tr.case_id.nil?
                   _trid=tr.case_id
                   _tpos=index
                    self.trans.each_with_index do |tr2, index2|                                                     # Get the total for the current transaction
                        if !tr2.case_id.nil?
                            if tr.case_id==tr2.case_id
                                if index!=index2
                                    errors.add(:base, 'Case Duplication')
                                    tr.errors.add(:case_id, 'Cannot Duplicate Case')
                                end
                            end 
                        end
                    end        
                end
            end        
        end         
    end
    
end
