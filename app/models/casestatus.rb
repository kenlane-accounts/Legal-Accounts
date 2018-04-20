class Casestatus < ActiveRecord::Base
    has_many :cases, :dependent => :restrict_with_error

    validates_presence_of :code

end
