class Outlaytype < ActiveRecord::Base
   has_many :trans, :dependent => :restrict_with_error

  validates_presence_of :outcode 
end
