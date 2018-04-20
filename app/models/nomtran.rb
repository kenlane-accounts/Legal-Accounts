class Nomtran < ActiveRecord::Base
  belongs_to :tranhead
  belongs_to :tran
  belongs_to :nominal
  belongs_to :case
  belongs_to :supplier
  belongs_to :vat
end
