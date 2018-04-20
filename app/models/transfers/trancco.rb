class Transfers::Trancco < Transfer

  validates_presence_of :fromcase
  validates_presence_of :tocase
  
  attr_accessor :clientoverdraw
  attr_accessor :askclientoverdraw
  attr_accessor :tNewClPay
  attr_accessor :tNewClRec

  after_create do 
    self.update_column(:trantype, 'TRN')
    self.update_column(:fromtype, 'C')
    self.update_column(:totype, 'C')
    
    # once saved need to store the transfer.id in the client payment .... for a relationship ....
    self.tNewClPay.update_column(:transfer_id, self)
    self.tNewClRec.update_column(:transfer_id, self)

  end 
  
  before_validation do 
  
    #If this is a transfer from a client account we need to create the client payment and receipt also ......
    if self.new_record?
      # If this is a new transfer .....  Create the Client Payment ....
      self.tNewClPay=Tranheads::Nobank.new({trref: self.reference, trdate: self.date, trpayrec: 'P', trtrantype: 'MAT', troffcli: 'C', case_id: self.fromcase_id, type: 'Tranheads::Nobank', transfer_id: self})
      self.tNewClPay.trans.new({trdetails: self.fromdetails, tramount: amount, type: 'Trancpmat', case_id: self.fromcase_id, askclientoverdraw: self.askclientoverdraw, clientoverdraw: self.clientoverdraw})
      
      # Create the client receipt
      self.tNewClRec=Tranheads::Nobank.new({trref: self.reference, trdate: self.date, trpayrec: 'R', trtrantype: 'MAT', troffcli: 'C', case_id: self.tocase_id, type: 'Tranheads::Nobank', transfer_id: self})
      self.tNewClRec.trans.new({trdetails: self.todetails, tramount: amount, type: 'Trancrmat', case_id: self.tocase_id})
    else 
      # We must update all of the fields .......  for the client payment 
      self.tNewClPay=Tranheads::Nobank.find_by(transfer_id: self.id, trpayrec: 'P')
      self.tNewClPay.trref=self.reference
      self.tNewClPay.trdate=self.date
      self.tNewClPay.case_id=self.fromcase_id

      tran1 = tNewClPay.trans.first
      tran1.trdetails=self.fromdetails
      tran1.tramount=self.amount
      tran1.case_id=self.fromcase_id
      tran1.askclientoverdraw=self.askclientoverdraw
      tran1.clientoverdraw=self.clientoverdraw

      unless tran1.save
        tran1.errors[:base].each do |key, value|
          errors.add(:base, value)
        end 
      end

      # We must update all of the fields .......  for the client receipt
      self.tNewClRec=Tranheads::Nobank.find_by(transfer_id: self.id, trpayrec: 'R')
      self.tNewClRec.trref=self.reference
      self.tNewClRec.trdate=self.date
      self.tNewClRec.case_id=self.tocase_id

      tran2 = tNewClRec.trans.first
      tran2.trdetails=self.todetails
      tran2.tramount=self.amount
      tran2.case_id=self.tocase_id

      unless tran2.save
        tran2.errors[:base].each do |key, value|
          errors.add(:base, value)
        end 
      end

    end 

    if !self.tNewClPay.save
      self.clientoverdraw=self.tNewClPay.trans.first.clientoverdraw
      self.askclientoverdraw=self.tNewClPay.trans.first.askclientoverdraw
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
