class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new(author_id: current_user.id, post_id: @post)
    if @like.save
      flash[:notice] = 'Like was successfully created'
      redirect_to user_post_path(user_id: @post.author_id, id: @post.id)
    else
      render :new, alert: 'Error Occured While Liking The Post'
    end
  end
end
