class Tranopsup < Tran
  
  validates_presence_of :trdetails
  validates_presence_of :tramount
  validates_presence_of :supplier
    
  # Amount must be a number greater than 00.01
  validates_numericality_of :tramount, :greater_than_or_equal_to => 0.01

  after_save do 
    self.update_column(:netamount, tramount)
  end 

  after_create do

    # This is to add a record to the Nomtrans Table for the Nominal
    Nomtran.create({ amount: tramount, date: tranhead.trdate, 
                     supplier_id: supplier_id, ttype: 'P', tran: self, nomcode: "CREDITOR" })

  end


end 