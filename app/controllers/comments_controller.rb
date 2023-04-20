class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new(author_id: @user.id, text: params[:comment][:text], post_id: @post.id) # assign post_id
    if @comment.save # check if the comment is saved successfully
      flash[:success] = 'Comment was successfully created.'
      redirect_to user_post_path(@user.id, @post)
    else
      flash[:error] = 'Something went wrong.'
      render :new # render the new template again with error messages
    end
  end
end
