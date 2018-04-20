class Transfers::Trannmo < Transfer

  validates_presence_of :tocase, :message => "Case must be entered"
  validates_presence_of :fromnominal, :message => "Nominal must be entered"

  attr_accessor :tNewPay
  attr_accessor :tNewRec
  
  after_create do 
    self.update_column(:trantype, 'TRN')
    self.update_column(:fromtype, 'N')
    self.update_column(:totype, 'M')

    # once saved need to store the transfer.id in the client payment .... for a relationship ....
    self.tNewPay.update_column(:transfer_id, self)
    self.tNewRec.update_column(:transfer_id, self)

  end 
  
  before_validation do 
  
    #If this is a transfer from a client account we need to create the client payment and receipt also ......
    if self.new_record?

      # If this is a new transfer .....  Create the Client Payment ....
      self.tNewPay=Tranheads::Nobank.new({trref: self.reference, trdate: self.date, trpayrec: 'P', trtrantype: 'MAT', troffcli: 'O', case_id: self.tocase_id, transfer_id: self})
      self.tNewPay.trans.new({trdetails: self.fromdetails, tramount: amount, netamount: amount, vatamount: 0, vatperc: 0, type: 'Tranopmat', case_id: self.tocase_id})

      self.tNewRec=Tranheads::Nobank.new({trref: self.reference, trdate: self.date, trpayrec: 'R', trtrantype: 'MAT', troffcli: 'O', transfer_id: self})
      self.tNewRec.trans.new({trdetails: self.todetails, tramount: amount, netamount: amount, vatamount: 0, vatperc: 0, type: 'Tranornom', nominal_id: self.fromnominal_id})

    else 
      # We must update all of the fields .......  for the client payment 
      self.tNewPay=Tranheads::Nobank.find_by(transfer_id: self.id, trpayrec: 'P')
      self.tNewPay.trref=self.reference
      self.tNewPay.trdate=self.date
      self.tNewPay.case_id=self.fromcase_id

      tran1 = self.tNewPay.trans.first
      tran1.trdetails=self.fromdetails
      tran1.tramount=self.amount
      tran1.netamount=self.amount
      tran1.case_id=self.tocase_id

      unless tran1.save
        tran1.errors[:base].each do |key, value|
          errors.add(:base, value)
        end 
      end

      self.tNewRec=Tranheads::Nobank.find_by(transfer_id: self.id, trpayrec: 'R')
      tran2 = self.tNewPay.trans.first
      tran2.trdetails=self.todetails
      tran2.tramount=self.amount
      tran2.netamount=self.amount
      tran2.nominal_id=self.fromnominal_id

      unless tran2.save
        tran2.errors[:base].each do |key, value|
          errors.add(:base, value)
        end 
      end

    end 

    if !self.tNewPay.save
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
