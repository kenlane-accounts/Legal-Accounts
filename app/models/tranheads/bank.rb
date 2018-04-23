class Tranheads::Bank < Tranhead
    belongs_to :bank, -> {where(isoffice: true)}, :class_name => 'Nominal'

    validates_presence_of :bank
    validate :Check_Client_Balances, on: :create
    validate :Check_Client_Banks_Bals, on: :create
    validate :Check_Dup_Case

    def Check_Client_Banks_Bals
        # Get the total for each of the client banks that were user first ......
        clbanktots=Hash.new                     # Initialize the HASH -- this is where all previous balances will be storred
        self.trans.each do |tr|                                                     # Get the total for the current transaction
            if !tr.fromclientbank.nil?
                if clbanktots[tr.fromclientbank_id].nil?
                    clbanktots[tr.fromclientbank_id] = tr.tramount
                else
                    ttot=clbanktots[tr.fromclientbank_id]
                    ttot=ttot + tr.tramount
                    clbanktots[tr.fromclientbank_id] = ttot
                end
            end 
        end 
        # We now have all of the totals for the bank accounts -- Next skip through these and check the balances .......
        clbanktots.each do |key, value|
            ttrantotal=clbanktots[key]
            if ttrantotal!=0
                tbankbal=Nomtran.where('nominal_id='+key.to_s).sum(:amount)        # Get exists balance
                if tbankbal-ttrantotal<0                              # Take current transaction overall total from bank balance to see if <0  (torigamt is original amount for the edit)
                    errors.add(:base, 'Cannot save transaction, Insufficient funds in the Client Bank account : '+Nominal.find(key).code)
                end
            end                 
        end 
    end

    def Check_Client_Balances
        # This Validation is only for the Receipt from Client Bank to ensure it doesn't overdraw the client case ............
        self.trans.each do |tr|                                                     # Get the total for the current transaction
            tr.askclientoverdraw=false
            if !tr.case_id.nil?
                if !tr.tramount.nil?
                    if !tr.fromclientbank.nil?
                        tclbal=Nomtran.where(case_id: tr.case_id, nomcode: "CLIENT").sum(:amount)
                        if tclbal.nil?
                           tclbal=0 
                        end
                        tclbal=tclbal*-1
                        tnewbal=tclbal-tr.tramount.abs
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

    def Check_Dup_Case
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
