class Client < ActiveRecord::Base
  has_many :cases, :dependent => :restrict_with_error
  belongs_to :clientstatus
  
  validates_presence_of :firstname
  validates_presence_of :lastname
  validates_presence_of :clientstatus


  def info
      "#{firstname}  #{middlename}  #{lastname}"
  end
end
