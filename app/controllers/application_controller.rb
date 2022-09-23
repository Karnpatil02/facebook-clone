class ApplicationController < ActionController::Base
include SessionsHelper
 protect_from_forgery with: :null_session
 before_action :set_current_user
 
  private
    def logged_in_user
        unless logged_in?
          @current = user.id  
          flash[:danger] = "Please log in."
          redirect_to main_users_path
        end
    end

    def set_current_user
      @current_user ||= session[:user_id] && User.find_by_id(session[:user_id])
    end
        
end
