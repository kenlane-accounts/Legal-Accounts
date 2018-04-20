class Tranopmat < Tran

  validates_presence_of :trdetails
  validates_presence_of :tramount
  validates_presence_of :case, :message => "Case must be entered"

  # Amount must be a number greater than 00.01
  validates_numericality_of :tramount, :greater_than_or_equal_to => 0.01

  after_create do 
    tranhead.update_column(:trtrantype, 'MAT')
    tranhead.update_column(:troffcli, 'O')
    tranhead.update_column(:trpayrec, 'P')
  end 

  after_save do 
    _tramount=self.tramount*-1
    self.update_column(:netamount, _tramount)
    self.update_column(:tramount, _tramount)

    self.nomtran.delete_all

    # This is to add a record to the Nomtrans Table for the Nominal
    Nomtran.create({ amount: tramount*-1, date: tranhead.trdate, 
                     case_id: case_id, ttype: 'P', tran: self, nomcode: 'OUTLAY' })

  end

end 
