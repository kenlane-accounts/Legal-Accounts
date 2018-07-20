class Tranormat < Tran

  has_many :allocations, foreign_key: 'receipt_tran_id', dependent: :delete_all

  validates_presence_of :trdetails
  validates_presence_of :tramount
  validates_presence_of :case

  # Amount must be a number greater than 00.01
  validates_numericality_of :tramount, :greater_than_or_equal_to => 0.01

  after_create do 
    tranhead.update_column(:trtrantype, 'MAT')
    tranhead.update_column(:troffcli, 'O')
    tranhead.update_column(:trpayrec, 'R')

    #If this is a transfer from a client account we need to create the client payment also ......
    if !self.fromclientbank_id.nil?
      tNewClPay=Tranheads::Bankclient.new({novalidation: true, trref: tranhead.trref, trdate: tranhead.trdate, trpayrec: 'P', trtrantype: 'MAT', troffcli: 'C', case_id: tranhead.case_id, type: 'Tranheads::Bankclient', bank_id: self.fromclientbank_id })
      tNewClPay.trans.new({trdetails: self.trdetails, tramount: tramount, type: 'Trancpmat', case_id: case_id})
      if !tNewClPay.save
        errors.add(:base, 'Case Client account will be overdrawn - Click on check box to continue with save')
        errors.add(:fromclientbank, 'Error adding the client transaction')
      end
    end

  end 

  after_save do 
    self.update_column(:netamount, tramount)

    self.nomtran.delete_all

    if self.troutlaybill[0]=='O'
      _outbill='OUTLAY'
    else
      _outbill='DEBTOR'
    end 
    
    # This is to add a record to the Nomtrans Table for the Nominal
    Nomtran.create({ amount: tramount*-1, date: tranhead.trdate, 
                     case_id: case_id, ttype: 'R', tran: self, nomcode: _outbill })


  end

  def allocated
    allocations.sum(:amount)
  end

  def to_alloc
    tramount - allocated
  end
end 
