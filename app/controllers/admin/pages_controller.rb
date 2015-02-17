class Admin::PagesController < AdminController
  def contact
    @contact_poster = Post.find_by_title("Contact Poster")
    @recent_projects = Post.find_by_title("Recent Projects")
    @about_me = Post.find_by_title("About Me")
    @work_with_me = Post.find_by_title("Work With Me")
  end
end
