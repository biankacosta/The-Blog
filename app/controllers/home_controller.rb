class HomeController < ApplicationController
  def index
    @recent_posts = Post.order(created_at: :desc).limit(5)
  end
end
