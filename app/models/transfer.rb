class Transfer < ActiveRecord::Base
  has_many :tranheads, dependent: :destroy

  belongs_to :fromnominal, :class_name => 'Nominal'
  belongs_to :tonominal, :class_name => 'Nominal'

  belongs_to :fromcase, :class_name => 'Case'
  belongs_to :tocase, :class_name => 'Case'
  
  validates_presence_of :date
  validates_presence_of :reference
  validates_presence_of :amount
  validates_presence_of :fromdetails
  validates_presence_of :todetails

  validates_numericality_of :amount, :greater_than_or_equal_to => 0.01

end
