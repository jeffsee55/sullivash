class MessagesController < AdminController

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to :back, notice: "Message was successfully submitted, we'll be in touch!"
    else
      redirect_to :back, notice: "We're sorry, there was a problem submitting your message. Please contact us at stefanie@example.com"
    end
  end

  private

  def message_params
    params.require(:message).permit(:name, :email, :body)
  end
end
