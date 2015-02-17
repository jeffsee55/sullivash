class Admin::ImagesController < AdminController
  skip_before_filter :verify_authenticity_token

  def create
    @image = Image.new
    # retrieve the image
    image = params[:file].instance_variable_get('@tempfile')
    # send to refile
    @image.image = image
    # return json
    @image.save
    render :json => { link: "/attachments/store/#{@image.image.id}/image" }
  end

  def show
    @image = Image.find(params[:id])
  end

  def destroy
    src = params[:src]
    image_id = src.split("/")[3]
    refile_object = Refile::File.new(self, image_id)
    @image = Image.where(image_id: refile_object.id).last
    @image.destroy
    render js: 200
  end
end
