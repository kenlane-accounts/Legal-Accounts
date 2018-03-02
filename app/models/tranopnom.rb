class Tranopnom < Tran
  
  validates_presence_of :trdetails
  validates_presence_of :tramount
  validates_presence_of :nominal

  # Amount must be a number greater than 00.01
  validates_numericality_of :tramount, :greater_than_or_equal_to => 0.01
  validates_numericality_of :netamount, :greater_than_or_equal_to => 0.01

  after_save do 
    self.update_column(:vatperc, vat.vatperc)
  end 

  after_create do
    
    # This is to add a record to the Nomtrans Table for the Nominal
    Nomtran.create({ amount: netamount, date: tranhead.trdate, 
                     nominal_id: nominal_id, ttype: 'P', tran: self, nomcode: nominal.code })

    # This is to add a record to the Nomtrans Table for the VAT
    Nomtran.create({ amount: vatamount, date: tranhead.trdate, 
                     vat_id: vat_id, ttype: 'P', tran: self, nomcode: "VAT" })
                     
  end

end 
