class Tranhead < ActiveRecord::Base
    has_many :trans, dependent: :destroy
    has_many :nomtrans, dependent: :destroy

    belongs_to :transfers

    validates_presence_of :trref

    accepts_nested_attributes_for :trans, :reject_if => :all_blank, allow_destroy: true

    @cnt='1'

    after_save do
        #Total of all lines in for the BANK .......


        _tid=self.trans.first
        _tPayRec=_tid.type[5,1].upcase           # For some reason the TRPACREC not available below and need it for the Nomtrans  (It does save to tranhead later though)
        tRec=self.trans.sum(:tramount)
        
        self.nomtrans.delete_all

        case self.type
            when "Tranheads::Nobank"        
                # Do Nothing -- this is for transfers -- case to case transfer with no bank ....
            when "Tranheads::Woff"        
                Nomtran.create({ amount: tRec, date: self.trdate, 
                             case_id: self.case_id, ttype: _tPayRec, tran: _tid, nomcode: 'OUTLAY', tranhead_id: self.id })
            when "Tranheads::Pinv"        
                Nomtran.create({ amount: tRec*-1, date: self.trdate, 
                             supplier_id: self.supplier_id, ttype: _tPayRec, tran: _tid, nomcode: 'CREDITOR', tranhead_id: self.id })
            when "Tranheads::Sinv"        
                Nomtran.create({ amount: tRec, date: self.trdate, 
                             case_id: self.case_id, ttype: _tPayRec, tran: _tid, nomcode: 'DEBTOR', tranhead_id: self.id })
            else 
                Nomtran.create({ amount: tRec, date: self.trdate, 
                             nominal_id: self.bank_id, ttype: _tPayRec, tran: _tid, nomcode: bank.code, tranhead_id: self.id })
        end 
    end 

end
