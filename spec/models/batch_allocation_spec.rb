require 'rails_helper'

RSpec.describe BatchAllocation, type: :model do
  before do
    Company.current_company_id = 1
  end
  let(:invoice_tran) { create :invoice_tran }
  let(:receipt_tran) { create :receipt_tran, case_id: invoice_tran.tranhead.case_id }
  let(:batch_allocation) do
    b = BatchAllocation.new receipt_tran_id: receipt_tran.id
    b.allocations.each do |a|
      a.amount = 10
    end
    b
  end
  subject { batch_allocation }

  it { is_expected.to respond_to :receipt_tran_id }
  it { is_expected.to respond_to :receipt_tran }
  it { is_expected.to respond_to :allocations }
  it { is_expected.to respond_to :allocations_attributes }
  it { is_expected.to respond_to :save }

  it { is_expected.to be_valid }

  describe 'when no receipt tran' do
    before { batch_allocation.receipt_tran_id = nil }
    it { is_expected.to_not be_valid }
  end


  describe 'when no allocations' do
    before { allow(batch_allocation).to receive(:allocations).and_return [] }
    it { is_expected.to_not be_valid }
  end

  describe 'when allocation is not valid' do
    before do
      batch_allocation.allocations.first.amount = 0
    end
    it { is_expected.to_not be_valid }
  end

  describe '#save' do
    describe 'when not valid' do
      before { batch_allocation.receipt_tran_id = nil }
      it 'returns false' do
        expect(batch_allocation.save).to be_falsey
      end

      it 'does not change allocations count' do
        expect { batch_allocation.save }.to_not change { Allocation.count }
      end
    end
    describe 'when valid' do
      it { is_expected.to be_valid }
      it 'returns true' do
        expect(batch_allocation.save).to be_truthy
      end

      it 'does creates allocation records' do
        expect { batch_allocation.save }.to change { Allocation.count }
      end
    end

    describe 'when there is an allocation with empty amount' do
      let(:batch_allocation) do
        invoice_tran2 = create :invoice_tran
        invoice_tran2.tranhead.update! case_id: receipt_tran.case_id

        invoice_tran3 = create :invoice_tran
        invoice_tran3.tranhead.update! case_id: receipt_tran.case_id

        b = BatchAllocation.new receipt_tran_id: receipt_tran.id
        b.allocations.each_with_index do |a, i|
          a.amount = 10 if i == 0
        end
        b
      end

      it { is_expected.to_not be_valid }
      it 'returns true' do
        expect(batch_allocation.save).to be_truthy
      end

      it 'does creates allocation records' do
        expect { batch_allocation.save }.to change { Allocation.count }.by 1
      end
    end
  end
end
