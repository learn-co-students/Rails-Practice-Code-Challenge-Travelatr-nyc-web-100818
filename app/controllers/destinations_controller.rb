class DestinationsController < ApplicationController
  before_action :find_destination, only: [:show]

  def show
    @most_recent_posts = @destination.most_recent_posts
    @most_featured_post = @destination.most_featured_post
    @ave_age = @destination.ave_age
  end

  private


  def find_destination
    @destination = Destination.find_by(id: params[:id])
  end

  def destination_params
    params.require(:destination).permit(:name, :country)
  end

end
