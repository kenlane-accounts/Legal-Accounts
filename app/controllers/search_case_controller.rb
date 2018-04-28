class SearchCaseController < ApplicationController
  def search
    @cases = Case.where('reference like ?', "%#{params[:search_case_reference]}%")
    # render :json => @cases.map{ |c| { :id => c.id, :reference => c.reference } }
  end
end