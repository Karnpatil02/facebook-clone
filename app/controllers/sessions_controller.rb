class SessionsController < ApplicationController
 
  def new  
  end   
 
  def create   

	  user = User.find_by(email: params[:email].downcase)
	   if user.present? && user.authenticate(params[:password])
	    if user.email_confirmed
        redirect_to posts_path    
	    else
        flash.now[:error] = 'Please activate your account by following the instructions in the account confirmation email you received to proceed'
        render 'new'
       end
	      session[:user_id] = user.id
	      flash[:success] = 'login successfull'
	     
	    else
	      flash.now[:error] = 'Invalid email/password combination'
	      render :new
	    end
  end

   def destroy   
	    session[:user_id] = nil   
	    redirect_to root_url, notice: 'Logged out!'   
   end   
end
