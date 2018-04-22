class Supplier < ActiveRecord::Base
   has_many :tranheads, :dependent => :restrict_with_error
   has_many :trans, :dependent => :restrict_with_error
   has_many :nomtrans, :dependent => :restrict_with_error

  validates_presence_of :supcode 
  validates_presence_of :supname

   default_scope { where(company_id: Company.current_company_id) }
end
