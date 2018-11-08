class Blogger < ApplicationRecord
  has_many :posts
  has_many :destinations, through: :posts
  validates :name, uniqueness: true
  validates :bio, length: { minimum: 30}

  def total_likes
    self.posts.reduce(0) { |sum, post| sum + post.likes }
  end

  def featured_post
    likes = 0
    f_post = nil
    self.posts.each { |post| f_post = post if post.likes > likes }
    f_post
  end

  def top_5_destinations
    top_5 = []
    top_5_destination_names = []
    ordered_by_likes_ascending = self.posts.sort { |post| post.likes }
    ordered_by_likes_descending = ordered_by_likes_ascending.reverse
    top_5_destination_ids = ordered_by_likes_descending[0...5].map { |post| post.destination_id }
    x = 1
    id_array = check_for_duplicates(top_5_destination_ids, ordered_by_likes_descending, x)
    id_array.each { |num| top_5_destination_names << Destination.find_by(id: num).name }
    top_5_destination_names
  end

  def check_for_duplicates(top_5_destination_ids, ordered_by_likes_descending, x)
    while top_5_destination_ids.uniq! != nil
      top_5_destination_ids = ordered_by_likes_descending[0...5+x].map { |post| post.destination_id }.uniq
      x += 1
    end
    top_5_destination_ids
  end

end
