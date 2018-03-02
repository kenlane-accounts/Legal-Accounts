class Nominal < ActiveRecord::Base
   has_many :trans
   has_many :bank, :class_name => 'Tranhead', :foreign_key => 'bank_id'
   
   has_many :nomtrans
end
