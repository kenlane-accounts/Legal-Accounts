class Tran < ActiveRecord::Base
  belongs_to :tranhead
  belongs_to :vat
  belongs_to :nominal
  belongs_to :supplier

  has_many :nomtran, :foreign_key => 'tran_id', dependent: :destroy

end
