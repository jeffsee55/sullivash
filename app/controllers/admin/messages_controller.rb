class Admin::MessagesController < AdminController
  before_filter :get_message, only: [:show, :destroy]

  def show
  end

  def index
    @messages = Message.all
  end

  def destroy
    @message.delete
    redirect_to admin_messages_path, notice: "Message was successfully deleted."
  end

  private
    def get_message
      @message = Message.find(params[:id])
    end
end
