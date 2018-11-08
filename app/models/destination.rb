class Destination < ApplicationRecord
  has_many :posts
  has_many :bloggers, through: :posts


  def most_recent_posts
    posts_ordered = self.posts.sort { |post| post.created_at }
    posts_ordered = posts_ordered.reverse
    posts_ordered[0...5]
  end

  def most_featured_post
    popularity_ascending = self.posts.sort { |post| post.likes }
    popularity_descending = popularity_ascending.reverse
    popularity_descending.first
  end

  def ave_age
    uniq_bloggers = self.bloggers.uniq
    num_of_bloggers = uniq_bloggers.count
    total_age = uniq_bloggers.reduce(0) { |num, blogger| num + blogger.age }
    if num_of_bloggers != 0
      total_age / num_of_bloggers
    else
      "No Bloggers"
    end
  end
end
