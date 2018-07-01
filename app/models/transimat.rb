class Transimat < Tran

  has_many :allocations, foreign_key: 'invoice_tran_id'
  validates_presence_of :trdetails
  validates_presence_of :tramount
  validates_presence_of :nominal

  # Amount must be a number greater than 00.01
  validates_numericality_of :tramount, :greater_than_or_equal_to => 0.01

  after_create do 
    tranhead.update_column(:trtrantype, 'MAT')
    tranhead.update_column(:troffcli, 'S')
    tranhead.update_column(:trpayrec, 'I')
  end 

  after_save do 
    
    self.update_column(:case_id, tranhead.case_id)

    self.nomtran.delete_all

    if !self.vat.nil?
      self.update_column(:vatperc, self.vat.vatperc)
    end

    if !self.netamount.nil?
      if self.netamount != 0
        # This is to add a record to the Nomtrans Table for the Fees
        Nomtran.create({ amount: netamount*-1, date: tranhead.trdate, 
                         nominal_id: nominal_id, ttype: 'I', tran: self, nomcode: nominal.code })
      end
    end 
    
    if !self.vat.nil?
      if self.vatamount != 0
        # This is to add a record to the Nomtrans Table for the VAT
        Nomtran.create({ amount: vatamount*-1, date: tranhead.trdate, 
                         vat_id: vat_id, ttype: 'I', tran: self, nomcode: 'VAT' })
      end
    end 
    
    if !self.outamount.nil?
      if self.outamount != 0
        # This is to add a record to the Nomtrans Table for the Outlay
        Nomtran.create({ amount: outamount*-1, date: tranhead.trdate, 
                         case_id: tranhead.case_id, ttype: 'I', tran: self, nomcode: 'OUTLAY' })
      end
    end
  end

  def allocated
    allocations.sum(:amount)
  end

  def to_alloc
    tramount - allocated
  end

end 
