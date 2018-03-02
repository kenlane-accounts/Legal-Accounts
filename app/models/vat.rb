class Vat < ActiveRecord::Base
    has_many :trans
    has_many :nomtrans

    def info
        "#{vatcode}  -  #{vatperc}"
    end
end
