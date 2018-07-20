require 'rails_helper'

RSpec.describe Transimat, type: :model do
  before { Company.current_company_id = 1 }

  let(:transimat) { build :transimat, tramount: 100 }
  subject { transimat }

  it { is_expected.to respond_to :allocated }
  it { is_expected.to respond_to :to_alloc }

  describe "#allocated" do
    describe 'when no allocations' do
      it 'returns 0' do
        expect(transimat.allocated).to eq 0.0
      end
    end

    describe 'when allocation exists' do
      before { transimat.save! }
      let!(:allocation) do
        create :allocation, invoice_tran: transimat, amount: 10
        # a = build :allocation, invoice_tran: transimat
        # a.invoice_tran.tranhead.update! case_id: tranormat.case_id
        # a.save!
        # a
      end

      it 'returns allocation amount' do
        expect(transimat.allocated).to eq 10
      end
    end
  end

  describe "#to_alloc" do
    describe 'when no allocations' do
      it 'returns total amount' do
        expect(transimat.to_alloc).to eq 100
      end
    end

    describe 'when allocation exists' do
      before { transimat.save! }
      let!(:allocation) do
        create :allocation, invoice_tran: transimat, amount: 10
        # a = build :allocation, invoice_tran: transimat, amount: 10
        # a.receipt_tran.update! case_id: transimat.tranhead.case_id
        # a.save!
        # a
      end

      it 'returns amount difference' do
        expect(transimat.to_alloc).to eq 90
      end
    end
  end

  describe '#destroy' do
    describe 'when it has allocations' do
      before do
        transimat.save!

        a = build :allocation, invoice_tran: transimat, amount: 10
        # a.receipt_tran.update! case_id: transimat.tranhead.case_id
        a.save!
      end

      it 'prevents deleting' do
        expect { transimat.destroy }.to_not change { Transimat.count }
      end
    end
  end

  describe '#vat_allocated' do
    before { transimat.save! }
    describe 'when no allocations' do
      it 'returns 0' do
        expect(transimat.vat_allocated).to eq 0.0
      end
    end

    describe 'when allocations exists' do
      let!(:allocation) do
        create :allocation, invoice_tran: transimat, amount: 10
      end

      it 'returns amount difference' do
        expect(transimat.vat_allocated).to eq allocation.vat
      end
    end
  end
end
