class Admin::DashboardController < AdminController

  def home
    @unpublished_posts = Post.unpublished.first(4)
    @unpublished_posts_remaining = Post.unpublished.count - 4
    @user = User.last
  end

  def site_posts
    @site_posts = Post.site_post.all
  end

end
