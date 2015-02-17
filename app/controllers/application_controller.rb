class ApplicationController < ActionController::Base
  include Clearance::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_query, :set_theme, :set_menu, :set_user

  private

  def set_menu
    @menu ||= Menu.last
  end

  def set_theme
    @theme ||= Theme.last
  end

  def set_query
    @q = Post.ransack(params[:q])
  end

  def set_user
    @user = User.last
  end
end
