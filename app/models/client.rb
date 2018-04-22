class Client < ActiveRecord::Base
  has_many :cases, :dependent => :restrict_with_error
  belongs_to :clientstatus
  
  validates_presence_of :firstname
  validates_presence_of :lastname
  validates_presence_of :clientstatus

  default_scope { where(company_id: Company.current_company_id) }

  def info
      "#{firstname}  #{middlename}  #{lastname}"
  end
end
