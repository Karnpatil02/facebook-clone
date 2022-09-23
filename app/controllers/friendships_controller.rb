class FriendshipsController < ApplicationController
  before_action :find_friendship, only: [:edit,:destroy]
   before_action :set_current_user

  
  def create
    user = User.find(params[:friend_id])
    @friendship = Friendship.create(user_id: current_user.id, friend_id: user.id, status: false)
    if @friendship.save
      flash[:success] = 'Friendship request successfull'
      redirect_to users_path
    else
      flash[:danger] = 'Cannot send friendship request'
      redirect_to users_path
    end
  end


  def edit
     if @friendship_id.update(status: true)
      flash[:success] = 'Friendship request accepted'
      redirect_to users_path
    else
      flash[:danger] = 'Friendship request not accepted'
      redirect_to users_path
    end
  end


  def destroy
    if @friendship_id
      @friendship_id.destroy
      flash[:success] = 'Friendship request canceled'
      redirect_to users_path
    else
      flash[:danger] = 'Friendship request NOT canceled'
    end
  end

  private

  def find_friendship
    @friendship_id = Friendship.find(params[:id])
  end


end
