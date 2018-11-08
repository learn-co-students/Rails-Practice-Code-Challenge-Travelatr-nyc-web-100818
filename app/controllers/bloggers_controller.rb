class BloggersController < ApplicationController
  before_action :find_blogger, only: [:show, :create]

  def show
    @posts = @blogger.posts
    @likes = @blogger.total_likes
    @featured_post = @blogger.featured_post
    @top_5_array = @blogger.top_5_destinations
  end

  def new
    @blogger = Blogger.new
  end

  def create
  end

  private

  def find_blogger
    @blogger = Blogger.find_by(id: params[:id])
  end

  def blogger_params
    params.require(:blogger).permit(:name, :bio, :age)
  end
end
