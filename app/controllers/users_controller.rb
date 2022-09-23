class UsersController < ApplicationController
   before_action :set_user, only: %i[ show edit update destroy profile ]
 
  def index
    @users = User.where.not(id: current_user.id)
    @friendships = current_user.friendships
    @inverse_friendships = current_user.inverse_friendships
    
  end

  def show
    @posts = Post.where(user_id: @current_user.id)
    @current_user = current_user
    @rooms = Room.public_rooms
    @users = User.all_except(@current_user)
    @room = Room.new
    @message = Message.new
    @room_name = get_name(@user, @current_user)
    @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, @current_user], @room_name)
    @messages = @single_room.messages
    
    render "rooms/index"    
  end

  def search
    @users = User.where.not(id: current_user.id)
    @users = User.where("first_name Like ?","%#{params[:q]}%")
  end

  def profile
   
  end

  def new
    @user = User.new
  end

  def edit
   @posts = Post.where(user_id: @current_user.id)
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        UserMailer.registration_confirmation(@user).deliver_now
        format.html { redirect_to root_path, alert: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
   end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), alert: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:success] = "Welcome to the facebook! Your email has been confirmed.
      Please sign in to continue."
      redirect_to root_path
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to new_user_path
    end
end

  def destroy
   @post = Post.find(params[:id])
   @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
   
    @user.destroy

    respond_to do |format|
      format.html { redirect_to root_path, alert: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
    
    def get_name(user1, user2)
      users = [user1, user2].sort
      "private_#{users[0].id}_#{users[1].id}"
    end

    def user_params
      params.require(:user).permit(:image_link,:email, :password, :first_name, :last_name, :age, :contact, :gender,:friend_id)
    end
end
