class NotificationsController < ApplicationController
  
  def index
   @notifications = Notification.where(recipient: current_user)
   @notifications = Notification.all
  end
end
