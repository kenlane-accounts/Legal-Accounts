class Tranpimat < Tran

  validates_presence_of :trdetails
  validates_presence_of :tramount
  validates_presence_of :case

  # Amount must be a number greater than 00.01
  validates_numericality_of :tramount, :greater_than_or_equal_to => 0.01

  after_create do 
    tranhead.update_column(:trtrantype, 'MAT')
    tranhead.update_column(:troffcli, 'P')
    tranhead.update_column(:trpayrec, 'I')
  end 

  after_save do 

    self.update_column(:netamount, self.tramount)

    self.nomtran.delete_all

    # This is to add a record to the Nomtrans Table for the Nominal
    Nomtran.create({ amount: tramount, date: tranhead.trdate, 
                     case_id: case_id, ttype: 'I', tran: self, nomcode: 'OUTLAY' })

  end

end 
