class Nominal < ActiveRecord::Base
   has_many :trans, :dependent => :restrict_with_error
   has_many :nomtrans, :dependent => :restrict_with_error
   has_many :bank, :class_name => 'Tranhead', :foreign_key => 'bank_id', :dependent => :restrict_with_error
   has_many :fromclientbank, :class_name => 'Tran', :foreign_key => 'FromClientBank_id', :dependent => :restrict_with_error


   has_many :frombank, :class_name => 'Transfer', :foreign_key => 'frombank_id', :dependent => :restrict_with_error
   has_many :tobank, :class_name => 'Transfer', :foreign_key => 'tobank_id', :dependent => :restrict_with_error
   has_many :fromnominal, :class_name => 'Transfer', :foreign_key => 'fromnominal_id', :dependent => :restrict_with_error
   has_many :tonominal, :class_name => 'Transfer', :foreign_key => 'tonominal_id', :dependent => :restrict_with_error

  validates_presence_of :code 
  validates_presence_of :desc

   default_scope { where(company_id: Company.current_company_id) }

  def banksel
     if self.isclient
      "Client Bank - #{code}"
     else
      "Office Bank - #{code}"
     end
  end

end
