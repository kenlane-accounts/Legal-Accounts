class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  around_filter :scope_current_company

  def scope_current_company
    Company.current_company_id = 1
    yield
  ensure
    Company.current_company_id = nil
  end

end
