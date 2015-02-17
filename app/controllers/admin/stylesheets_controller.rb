class Admin::StylesheetsController < AdminController
  layout nil

  def new
    @stylesheet = Stylesheet.new
  end

  def show
    styles = Stylesheet.find(params[:id])
    base_stylesheet_path = Rails.root.join('app', 'assets', 'profile.scss')

    # Build the string of SCSS we'll pass to the Sass rendering engine
    @sass = <<-SASS
      #{styles.to_sass}
      @import "#{base_stylesheet_path}";
    SASS

    # Cache for long time
    response.headers['Cache-Control'] = "public, max-age=#{1.year}"

    respond_to do |format|
      format.css
    end
  end

  def create
    @stylesheet = Stylesheet.new
    @stylesheet.variables = {}
    @stylesheet.variables[:header_bg] = params[:stylesheet][:variables]
    @stylesheet.save
    redirect_to admin_path
  end

  private

    def stylesheet_params
      params.require(:stylesheet).permit(:variables)
    end
end
