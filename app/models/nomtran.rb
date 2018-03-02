class Nomtran < ActiveRecord::Base
  belongs_to :tran
  belongs_to :nominal
  
  belongs_to :supplier
  belongs_to :vat
end
