require 'rails_helper'

RSpec.describe Allocation, type: :model do
  let(:allocation) { build :allocation }
  subject { allocation }

  it { is_expected.to respond_to :amount }
  it { is_expected.to respond_to :vat }
  it { is_expected.to respond_to :invoice_tran_id }
  it { is_expected.to respond_to :receipt_tran_id }
  it { is_expected.to respond_to :receipt_tran }

  it { is_expected.to be_valid }

  it 'debug' do
    a = 2
    expect(a).to eq 3
  end

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

  describe 'when case in receipt differs from invoice case' do
    before { allocation.receipt_tran.case_id = create(:case).id }
    it { is_expected.to_not be_valid }
  end
end
