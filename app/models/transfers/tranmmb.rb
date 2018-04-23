class Transfers::Tranmmb < Transfer

  belongs_to :frombank, -> {where 'isoffice=\'t\''}, :class_name => 'Nominal'
  belongs_to :tobank, -> {where 'isoffice=\'t\''}, :class_name => 'Nominal'

  validates_presence_of :fromcase
  validates_presence_of :tocase
  
  validates_presence_of :frombank
  validates_presence_of :tobank

  attr_accessor :tNewClPay
  attr_accessor :tNewClRec

  after_create do 
    self.update_column(:trantype, 'TRN')
    self.update_column(:fromtype, 'M')
    self.update_column(:totype, 'M')
    
    # once saved need to store the transfer.id in the client payment .... for a relationship ....
    self.tNewClPay.update_column(:transfer_id, self)
    self.tNewClRec.update_column(:transfer_id, self)

  end 
  
  before_validation do 
  
    #If this is a transfer from a client account we need to create the client payment also ......
    if !self.frombank_id.nil?
      if self.new_record?
        # If this is a new transfer .....  Create the Client Payment ....
        self.tNewClPay=Tranheads::Bank.new({trref: self.reference, trdate: self.date, trpayrec: 'P', trtrantype: 'MAT', troffcli: 'M', case_id: self.fromcase_id, bank_id: self.frombank_id, transfer_id: self})
        self.tNewClPay.trans.new({trdetails: self.fromdetails, tramount: amount, type: 'Tranopmat', case_id: self.fromcase_id})
        
        # Create the client receipt
        self.tNewClRec=Tranheads::Bank.new({trref: self.reference, trdate: self.date, trpayrec: 'R', trtrantype: 'MAT', troffcli: 'M', case_id: self.tocase_id, bank_id: self.tobank_id, transfer_id: self})
        self.tNewClRec.trans.new({trdetails: self.todetails, tramount: amount, type: 'Tranormat', case_id: self.tocase_id, troutlaybill: 'Outlay'})

      else 
        
        # We must update all of the fields .......  for the client payment 
        self.tNewClPay=Tranheads::Bank.find_by(transfer_id: self.id, trpayrec: 'P')
        self.tNewClPay.trref=self.reference
        self.tNewClPay.trdate=self.date
        self.tNewClPay.case_id=self.fromcase_id
        self.tNewClPay.bank_id=self.frombank_id
        
        tran1 = tNewClPay.trans.first
        tran1.trdetails= fromdetails
        tran1.tramount= amount
        tran1.case_id= fromcase_id
        
        unless tran1.save
          tran1.errors[:base].each do |key, value|
            errors.add(:base, value)
          end 
        end

        # We must update all of the fields .......  for the client receipt
        self.tNewClRec=Tranheads::Bank.find_by(transfer_id: self.id, trpayrec: 'R')
        self.tNewClRec.trref=self.reference
        self.tNewClRec.trdate=self.date
        self.tNewClRec.case_id=self.tocase_id
        self.tNewClRec.bank_id=self.tobank_id
        
        tran2 = tNewClRec.trans.first
        tran2.trdetails=self.todetails
        tran2.tramount= amount
        tran2.case_id=self.tocase_id

        unless tran2.save
          tran2.errors[:base].each do |key, value|
            errors.add(:base, value)
          end 
        end
      end 
  
      if !self.tNewClPay.save
        self.tNewClPay.errors[:base].each do |key, value|
          errors.add(:base, key)
        end 
      end

      if !self.tNewClRec.save
        self.tNewClRec.errors[:base].each do |key, value|
          errors.add(:base, key)
        end 
      end 

    end

  end 

end 
