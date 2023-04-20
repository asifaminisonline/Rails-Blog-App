class PostsController < ApplicationController
  def index
    @user = User.includes(:posts).find(params[:user_id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def show
    @post = Post.includes(:comments, :likes).where(author_id: params[:user_id]).find(params[:id])
    @user = User.find(params[:user_id])
    comment = Comment.new
    like = Like.new
    respond_to do |format|
      format.html { render :show, locals: { comment:, like: } }
    end
  end

  def new
    new_post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: new_post } }
    end
  end

  def create
    post_params = params.require(:new_post).permit(:title, :text)
    post = Post.new(post_params)
    post.author = current_user
    post.comments_counter = 0
    post.likes_counter = 0
    respond_to do |format|
      format.html do
        if post.save
          flash[:notice] = 'Post created successfully'
          redirect_to users_path
        else
          Rails.logger.error(post.errors.full_messages)
          flash.now[:alert] = 'Post creation failed'
          render :new, locals: { post: }
        end
      end
    end
  end
end
