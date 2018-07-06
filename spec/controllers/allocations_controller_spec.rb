require 'rails_helper'

RSpec.describe AllocationsController, type: :controller do
  before { Company.current_company_id = 1 }

  describe 'GET #index' do
    it 'responds with success' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @allocations' do
      allocation = create :allocation
      get :index
      expect(assigns :allocations).to eq [allocation]
    end
  end

  describe 'DELETE #destroy' do
    let!(:allocation) { create :allocation }
    describe 'when can delete' do
      it 'deletes a record' do
        expect{ delete :destroy, id: allocation.id }.to change{ Allocation.unscoped.count }.by -1
      end
      it 'redirects to allocations' do
        delete :destroy, id: allocation.id
        expect(response).to redirect_to allocations_path
      end
    end

    describe 'when can not delete' do
      before { create :allocation, invoice_tran_id: allocation.invoice_tran_id }
      it 'does not delete a record' do
        expect{ delete :destroy, id: allocation.id }.to_not change{ Allocation.unscoped.count }
      end
      it 'redirects to allocations' do
        delete :destroy, id: allocation.id
        expect(response).to redirect_to allocations_path
      end
    end
  end
end
