class Admin::DashboardController < AdminController

  def home
    @unpublished_posts = Post.where(published_at: nil)
    @user = User.last
  end

  def site_posts
    @site_posts = Post.site_post.all
  end

end
