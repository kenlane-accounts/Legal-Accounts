class Case < ActiveRecord::Base
  belongs_to :client
  belongs_to :casestatus
  has_many :tranheads, :dependent => :restrict_with_error
  has_many :trans, :dependent => :restrict_with_error

  has_many :fromcase, :class_name => 'Transfer', :foreign_key => 'fromcase_id', :dependent => :restrict_with_error
  has_many :tocase, :class_name => 'Transfer', :foreign_key => 'tocase_id', :dependent => :restrict_with_error

  validates_presence_of :reference
  validates_presence_of :description
  validates_presence_of :casestatus

end
