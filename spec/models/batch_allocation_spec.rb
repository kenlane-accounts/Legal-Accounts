require 'rails_helper'

RSpec.describe BatchAllocation, type: :model do
  let(:batch_allocation) { BatchAllocation.new }
  subject { batch_allocation }

  it{ is_expected.to respond_to :receipt_tran_id }
  it{ is_expected.to respond_to :receipt_tran }
  it{ is_expected.to respond_to :allocations }
  it{ is_expected.to respond_to :allocations_attributes }

end
