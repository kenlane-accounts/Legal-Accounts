class Tranopnom < Tran
  
  validates_presence_of :trdetails
  validates_presence_of :tramount
  validates_presence_of :nominal

  # Amount must be a number greater than 00.01
  validates_numericality_of :tramount, :greater_than_or_equal_to => 0.01
  validates_numericality_of :netamount, :greater_than_or_equal_to => 0.01

  after_create do 
    tranhead.update_column(:trtrantype, 'NOM')
    tranhead.update_column(:troffcli, 'O')
    tranhead.update_column(:trpayrec, 'P')
  end 

  after_save do 
    _netamount=self.netamount*-1
    _vatamount=self.vatamount*-1
    _tramount=self.tramount*-1
    self.update_column(:netamount, _netamount)
    self.update_column(:tramount, _tramount)
    if !_vatamount.nil?
      self.update_column(:vatamount, _vatamount)
    end

    self.update_column(:vatperc, vat.try(:vatperc))

    self.nomtran.delete_all

    # This is to add a record to the Nomtrans Table for the Nominal
    Nomtran.create({ amount: netamount*-1, date: tranhead.trdate, 
                     nominal_id: nominal_id, ttype: 'P', tran: self, nomcode: nominal.code })

    if !self.vat.nil?
      if self.vatamount != 0
        # This is to add a record to the Nomtrans Table for the VAT
        Nomtran.create({ amount: vatamount*-1, date: tranhead.trdate, 
                         vat_id: vat_id, ttype: 'P', tran: self, nomcode: "VAT" })
      end
    end 

  end

end 
