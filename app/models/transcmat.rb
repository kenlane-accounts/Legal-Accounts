class Transcmat < Tran

  validates_presence_of :trdetails
  validates_presence_of :tramount
  validates_presence_of :nominal

  # Amount must be a number greater than 00.01
  validates_numericality_of :tramount, :greater_than_or_equal_to => 0.01

  after_create do 
    tranhead.update_column(:trtrantype, 'MAT')
    tranhead.update_column(:troffcli, 'S')
    tranhead.update_column(:trpayrec, 'C')
  end 

  after_save do 

    _netamount=self.netamount
    _vatamount=self.vatamount
    _tramount=self.tramount
    _outamount=self.outamount
    self.update_column(:netamount, _netamount*-1)
    self.update_column(:tramount, _tramount*-1)
    if !_vatamount.nil?
      self.update_column(:vatamount, _vatamount*-1)
    end
    if !_outamount.nil?
      self.update_column(:outamount, _outamount*-1)
    end

    self.nomtran.delete_all

    if !self.vat.nil?
      self.update_column(:vatperc, self.vat.vatperc)
    end

    if !self.netamount.nil?
      if self.netamount != 0
        # This is to add a record to the Nomtrans Table for the Fees
        Nomtran.create({ amount: netamount*-1, date: tranhead.trdate, 
                         nominal_id: nominal_id, ttype: 'C', tran: self, nomcode: nominal.code })
      end
    end 
    
    if !self.vat.nil?
      # This is to add a record to the Nomtrans Table for the VAT
      Nomtran.create({ amount: vatamount*-1, date: tranhead.trdate, 
                       vat_id: vat_id, ttype: 'C', tran: self, nomcode: 'VAT' })
    end 
    
    if !self.outamount.nil?
      # This is to add a record to the Nomtrans Table for the Outlay
      Nomtran.create({ amount: outamount*-1, date: tranhead.trdate, 
                       case_id: case_id, ttype: 'C', tran: self, nomcode: 'OUTLAY' })
    end

  end

end 
