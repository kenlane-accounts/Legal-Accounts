require 'rails_helper'

RSpec.describe Tranormat, type: :model do
  let(:tranormat) { build :tranormat }
  subject{ tranormat }

  it{ is_expected.to respond_to :allocated }
  it{ is_expected.to respond_to :to_alloc }

  describe "#allocated" do
    describe 'when no allocations' do
      it 'returns 0' do
        expect(tranormat.allocated).to eq 0.0
      end
    end

    describe 'when allocation exists' do
      before { tranormat.save! }
      let!(:allocation) do
        a = build :allocation, receipt_tran: tranormat
        a.invoice_tran.tranhead.update! case_id: tranormat.case_id
        a.save!
        a
      end

      it 'returns allocation amount' do
        expect(tranormat.allocated).to eq allocation.amount
      end
    end
  end

  describe "#to_alloc" do
    describe 'when no allocations' do
      it 'returns total amount' do
        expect(tranormat.to_alloc).to eq tranormat.tramount
      end
    end

    describe 'when allocation exists' do
      before { tranormat.save! }
      let!(:allocation) do
        a = build :allocation, receipt_tran: tranormat, amount: 10
        a.invoice_tran.tranhead.update! case_id: tranormat.case_id
        a.save!
        a
      end

      it 'returns the rest' do
        expect(tranormat.to_alloc).to eq 40
      end
    end
  end
end
