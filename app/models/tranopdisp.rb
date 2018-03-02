class Tranopdisp < Tran
  belongs_to :tranhead
  belongs_to :vat
  belongs_to :nominal

  has_many :nomtran, dependent: :destroy

  validates_presence_of :trdetails
  validates_presence_of :tramount
  validates_presence_of :nominal

  # Amount must be a number greater than 00.01
  validates_numericality_of :tramount, :greater_than_or_equal_to => 0.01
  validates_numericality_of :netamount, :greater_than_or_equal_to => 0.01



end 
