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

  describe '#before_create' do
    describe 'when invoice has no outlay' do
      before { allocation.invoice_tran.update! outamount: nil }

      describe 'when allocate full amount' do
        let(:amount) { allocation.invoice_tran.tramount }
        before do
          allocation.receipt_tran.update! tramount: amount
          allocation.amount = amount
        end

        it 'calcs vat' do
          allocation.save!
          expect(allocation.vat).to eq (amount - (amount * 100.0 / (100 + allocation.invoice_tran.vatperc))).round(2)
        end
      end

      describe 'when allocate full amount - real data' do
        let(:amount) { 930 }
        before do
          allocation.receipt_tran.update! tramount: amount
          allocation.invoice_tran.update! tramount: amount
          allocation.amount = amount
        end

        it 'calcs vat' do
          allocation.save!
          expect(allocation.vat).to eq 173.90
        end
      end

      describe 'when allocate partial amount' do
        let(:amount) { 930 }
        before do
          allocation.receipt_tran.update! tramount: amount
          allocation.invoice_tran.update! tramount: 1430
          allocation.amount = amount
        end

        it 'calcs vat' do
          allocation.save!
          expect(allocation.vat).to eq 173.90
        end
      end

    end

    describe 'when invoice has outlay' do
      before { allocation.invoice_tran.update! outamount: 200, netamount: 1000, tramount: 1430 }

      describe 'when allocate less than outamount' do
        let(:amount) { 100 }
        before do
          allocation.receipt_tran.update! tramount: 500
          allocation.amount = amount
        end

        describe 'when no other allocations' do
          it 'calcs vat' do
            allocation.save!
            expect(allocation.vat).to eq 0
          end
        end

        describe 'when other allocations exist' do
          before do
            Allocation.create! invoice_tran_id: allocation.invoice_tran_id, receipt_tran_id: allocation.receipt_tran_id,
                               amount: 100
          end
          it 'calcs vat' do
            allocation.save!
            expect(allocation.vat).to eq 0
          end
        end
      end

      describe 'when allocate greater than outamount' do
        describe 'when no other allocations' do
          let(:amount) { 500 }
          before do
            allocation.receipt_tran.update! tramount: 500
            allocation.amount = amount
          end
          it 'calcs vat' do
            allocation.save!
            expect(allocation.vat).to eq 56.10
          end
        end

        describe 'when other allocations exist' do
          describe 'when outlay fully allocated' do
            let(:amount) { 930 }
            before do
              allocation.receipt_tran.update! tramount: 2000
              allocation.amount = amount

              Allocation.create! invoice_tran_id: allocation.invoice_tran_id, receipt_tran_id: allocation.receipt_tran_id,
                                 amount: 500
            end
            it 'calcs vat' do
              allocation.save!
              expect(allocation.vat).to eq 173.9
            end
          end

          describe 'when outlay partially allocated' do
            let(:amount) { 930 }
            before do
              allocation.receipt_tran.update! tramount: 2000
              allocation.amount = amount

              Allocation.create! invoice_tran_id: allocation.invoice_tran_id, receipt_tran_id: allocation.receipt_tran_id,
                                 amount: 100
            end
            it 'calcs vat' do
              allocation.save!
              expect(allocation.vat).to eq 155.20 # 930 - (200 - 100) = 830; 830 - 830 / 1.23
            end
          end
        end
      end
    end
  end
end
