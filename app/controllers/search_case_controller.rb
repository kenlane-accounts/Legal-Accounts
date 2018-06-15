class SearchCaseController < ApplicationController
  def search
    @cases = Case.includes(:client).references(:clients).where 'cases.reference like :term OR cases.description like :term OR clients.lastname like :term',
                        term: "%#{params[:search_case_term]}%"
    # render :json => @cases.map{ |c| { :id => c.id, :reference => c.reference } }
  end
end