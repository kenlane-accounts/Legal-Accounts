class Supplier < ActiveRecord::Base
   has_many :trans
   has_many :nomtrans
end
