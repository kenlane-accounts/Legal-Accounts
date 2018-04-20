class Clientstatus < ActiveRecord::Base
    has_many :clients, :dependent => :restrict_with_error
    
    validates_presence_of :code
end
