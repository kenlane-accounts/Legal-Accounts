class Tranhead < ActiveRecord::Base
    has_many :trans, dependent: :destroy
    belongs_to :bank, -> {where(isoffice: true)}, :class_name => 'Nominal'

    validates_presence_of :bank
    validates_presence_of :trref

    accepts_nested_attributes_for :trans

    @cnt='1'

    after_save do
        #Total of all lines in for the BANK .......

        tRec=self.trans.sum(:tramount)*-1
        tid=self.trans.first
    
    
        Nomtran.create({ amount: tRec, date: self.trdate, 
                         nominal_id: self.bank_id, ttype: 'P', tran: tid, nomcode: bank.code })

    end 

end
