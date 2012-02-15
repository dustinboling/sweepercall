class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "You do not have permission to access this page."
    redirect_to :back
  end
  
end