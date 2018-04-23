class Transfers::Trancmb < Transfer

  belongs_to :frombank, -> {where 'isclient=\'t\''}, :class_name => 'Nominal'
  belongs_to :tobank, -> {where 'isoffice=\'t\''}, :class_name => 'Nominal'

  validates_presence_of :fromcase
  validates_presence_of :tocase
  
  validates_presence_of :frombank
  validates_presence_of :tobank

  attr_accessor :clientoverdraw
  attr_accessor :askclientoverdraw
  attr_accessor :tNewPay
  attr_accessor :tNewRec

  after_create do 
    self.update_column(:trantype, 'TRN')
    self.update_column(:fromtype, 'C')
    self.update_column(:totype, 'M')
    
    # once saved need to store the transfer.id in the client payment .... for a relationship ....
    self.tNewPay.update_column(:transfer_id, self)
    self.tNewRec.update_column(:transfer_id, self)

  end 
  
  before_validation do 
  
    #If this is a transfer from a client account we need to create the client payment also ......
    if !self.frombank_id.nil?
      if self.new_record?
        # If this is a new transfer .....  Create the Client Payment ....
        self.tNewPay=Tranheads::Bankclient.new({trref: self.reference, trdate: self.date, trpayrec: 'P', trtrantype: 'MAT', troffcli: 'C', type: 'Tranheads::Bankclient', case_id: self.fromcase_id, bank_id: self.frombank_id, transfer_id: self})
        self.tNewPay.trans.new({trdetails: self.fromdetails, tramount: amount, type: 'Trancpmat', case_id: self.fromcase_id, askclientoverdraw: self.askclientoverdraw, clientoverdraw: self.clientoverdraw})
        
        # Create the case receipt ...
        self.tNewRec=Tranheads::Bank.new({trref: self.reference, trdate: self.date, trpayrec: 'R', trtrantype: 'MAT', troffcli: 'M', case_id: self.tocase_id, bank_id: self.tobank_id, transfer_id: self})
        self.tNewRec.trans.new({trdetails: self.todetails, tramount: amount, type: 'Tranormat', case_id: self.tocase_id, troutlaybill: 'Outlay'})
      else 
        
        # We must update all of the fields .......  for the client payment 
        self.tNewPay=Tranheads::Bankclient.find_by(transfer_id: self.id, trpayrec: 'P')
        self.tNewPay.trref=self.reference
        self.tNewPay.trdate=self.date
        self.tNewPay.case_id=self.fromcase_id
        self.tNewPay.bank_id=self.frombank_id
        
        tran1 = tNewPay.trans.first
        tran1.trdetails= fromdetails
        tran1.tramount= amount
        tran1.case_id= fromcase_id
        tran1.askclientoverdraw=self.askclientoverdraw
        tran1.clientoverdraw=self.clientoverdraw
        
        unless tran1.save
          tran1.errors[:base].each do |key, value|
            errors.add(:base, value)
          end 
        end

        # We must update all of the fields .......  for the client receipt
        self.tNewRec=Tranheads::Bank.find_by(transfer_id: self.id, trpayrec: 'R')
        self.tNewRec.trref=self.reference
        self.tNewRec.trdate=self.date
        self.tNewRec.case_id=self.tocase_id
        self.tNewRec.bank_id=self.tobank_id
        
        tran2 = tNewRec.trans.first
        tran2.trdetails=self.todetails
        tran2.tramount= amount
        tran2.case_id=self.tocase_id

        unless tran2.save
          tran2.errors[:base].each do |key, value|
            errors.add(:base, value)
          end 
        end
      end 
  
      if !self.tNewPay.save
        self.clientoverdraw=self.tNewPay.trans.first.clientoverdraw
        self.askclientoverdraw=self.tNewPay.trans.first.askclientoverdraw
        self.tNewPay.errors[:base].each do |key, value|
          errors.add(:base, key)
        end 
      end

      if !self.tNewRec.save
        self.tNewRec.errors[:base].each do |key, value|
          errors.add(:base, key)
        end 
      end 

    end

  end 

end 
