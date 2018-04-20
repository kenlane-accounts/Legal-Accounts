class Tran < ActiveRecord::Base
  belongs_to :tranhead
  belongs_to :tranheadpi, :class_name => 'tranhead', foreign_key: 'tranhead_id'
  belongs_to :vat
  belongs_to :nominal
  belongs_to :supplier
  belongs_to :case  
  belongs_to :outlaytype
  belongs_to :fromclientbank, -> {where(isclient: true)}, :class_name => 'Nominal'

  has_many :nomtran, :foreign_key => 'tran_id', dependent: :destroy

  attr_accessor :askclientoverdraw
  attr_accessor :clientoverdraw
  attr_accessor :origamount                      # This is the original amount  (Need for checking if balance<0 for client account on the EDIT)

end
