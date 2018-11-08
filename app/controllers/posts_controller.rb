class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :like_post]

  def new
    @post = Post.new
    @bloggers = Blogger.all
    @destinations = Destination.all
  end
  def create
    @post = Post.create(post_params)
    if @post.valid?
      redirect_to @post
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to new_post_path
    end
  end
  def show
    #code
  end
  def edit
    @bloggers = Blogger.all
    @destinations = Destination.all
  end
  def update
    @post.update(post_params)
    if @post.valid?
      redirect_to @post
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to edit_post_path
    end
  end

  def like_post
    l = @post.likes
    @post.update(likes: l + 1)
    redirect_to @post
  end

  private

  def find_post
    @post = Post.find_by(id: params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :likes, :blogger_id, :destination_id)
  end
end
