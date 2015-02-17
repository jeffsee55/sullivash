class Admin::ThemesController < AdminController
  before_filter :get_theme, only: [:show, :edit, :destroy]

  def new
    @theme = Theme.new
  end

  def create
    @theme = Theme.new(theme_params)
    if @theme.save
      redirect_to :back, notice: "Your new theme has been saved."
    else
      render :new
    end
  end

  def show
  end

  def update
    @theme.update(theme_params)
    redirect_to :back, notice: "Your new theme has been saved."
  end

  def edit
  end

  def destroy
  end

  private

    def get_theme
      @theme = Theme.find(params[:id])
    end

    def theme_params
      params.require(:theme).permit(:header_bg, :footer_bg, :button_bg, :logo, :icon_color, :background_image, :primary_gradient, :secondary_gradient,
                                      :facebook, :pinterest, :instagram, :rss, :google_plus, :tagline)
    end
end
