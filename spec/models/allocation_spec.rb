require 'rails_helper'

RSpec.describe Allocation, type: :model do
  before { Company.current_company_id = 1 }
  let(:allocation) { build :allocation }
  subject { allocation }

  it { is_expected.to respond_to :amount }
  it { is_expected.to respond_to :vat }
  it { is_expected.to respond_to :invoice_tran_id }
  it { is_expected.to respond_to :receipt_tran_id }
  it { is_expected.to respond_to :receipt_tran }

  it { is_expected.to be_valid }

  describe 'when receipt tran is not present' do
    before { allocation.receipt_tran_id = nil }
    it { is_expected.to_not be_valid }
  end

  describe 'when invoice tran is not a sales invoice' do
    before { allocation.invoice_tran_id = create(:receipt_tran).id }
    it { is_expected.to_not be_valid }
  end

  describe 'when sales invoice tran is not present' do
    before { allocation.invoice_tran_id = nil }
    it { is_expected.to_not be_valid }
  end

  describe 'when receipt type is not Billing' do
    before { allocation.receipt_tran.troutlaybill = 'Outlay' }
    it { is_expected.to_not be_valid }
  end

  describe 'when amount is negative' do
    before { allocation.amount = -1 }
    it { is_expected.to_not be_valid }
  end

  describe 'when amount is 0' do
    before { allocation.amount = 0 }
    it { is_expected.to_not be_valid }
  end
  describe 'when amount is nil' do
    before { allocation.amount = nil }
    it { is_expected.to_not be_valid }
  end

  describe 'when amount is not a number' do
    before { allocation.amount = 'a' }
    it { is_expected.to_not be_valid }
  end

  describe 'when amount is greater than invoice total' do
    before { allocation.amount = allocation.invoice_tran.tramount + 0.01 }
    it { is_expected.to_not be_valid }
  end

  describe 'when amount is greater than invoice not allocated amount' do
    before do
      allocation.receipt_tran.update! tramount: allocation.invoice_tran.tramount + 20 # make sure then receipt has enough amount
      Allocation.create! receipt_tran: allocation.receipt_tran, invoice_tran: allocation.invoice_tran,
                        amount: allocation.invoice_tran.tramount - 10
      allocation.amount = 10.01
    end
    it 'has amount lesser than invoice total' do
      expect(allocation.amount).to be < allocation.invoice_tran.tramount
    end
    it { is_expected.to_not be_valid }
  end

  describe 'when amount is greater than receipt total' do
    before { allocation.amount = allocation.receipt_tran.tramount + 0.01 }
    it { is_expected.to_not be_valid }
  end

  describe 'when amount is greater than receipt not allocated amount' do
    before do
      Allocation.create! receipt_tran: allocation.receipt_tran, invoice_tran: allocation.invoice_tran,
                        amount: allocation.receipt_tran.tramount - 10
      allocation.amount = 10.01
    end
    it 'has amount lesser than invoice total' do
      expect(allocation.amount).to be < allocation.invoice_tran.tramount
    end
    it { is_expected.to_not be_valid }
  end

  describe 'when case in receipt differs from invoice case' do
    before { allocation.receipt_tran.case_id = create(:case).id }
    it { is_expected.to_not be_valid }
  end
end
