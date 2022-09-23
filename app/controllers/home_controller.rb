class HomeController < ApplicationController
 def index
 @post = Post.all
end

def about_us
end

def show
end
def create
end
 
 private
  def set_params
   @post = Post.find(params[:id])
  end
  def post_params
    params.require(:post).permit(:title, :body, :image,:user_id)
   end
 
end
