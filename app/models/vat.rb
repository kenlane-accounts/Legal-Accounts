class Vat < ActiveRecord::Base
    has_many :trans, :dependent => :restrict_with_error
    has_many :nomtrans, :dependent => :restrict_with_error

    validates_presence_of :vatcode 
    validates_presence_of :vatperc

    validates_numericality_of :vatperc, :greater_than_or_equal_to => 0.00, :less_than_or_equal_to => 99.99

    def info
        "#{vatcode}  -  #{vatperc}"
    end
end
