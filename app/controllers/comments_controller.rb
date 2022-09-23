class CommentsController < ApplicationController
 before_action :set_post
 
 def new
  @comment = Comment.new(parent_id: params[:parent_id, body])
 end

 def create
    @comment = @post.comment.create(comment_params)
    @comment.user_id = current_user.id
    redirect_to post_path(@post)
 end
 
 def destroy
    @comment = @post.comment.find(params[:id])
    @comment.destroy
    redirect_to posts_path(@post)
 end

 private 

 def set_post
   @post = Post.find(params[:post_id])
  end  

 def comment_params
   params.require(:comment).permit(:commenter, :body,:parent_id,:post_id, :user_id)
 end	
end
