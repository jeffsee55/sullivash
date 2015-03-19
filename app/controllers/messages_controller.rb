class MessagesController < ApplicationController

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to :back, notice: "Thanks for reaching out, we'll be in touch shortly."
    else
      redirect_to :back, alert: "We're sorry, there was a problem submitting your message. Please contact us at stefanie@example.com"
    end
  end

  private

  def message_params
    params.require(:message).permit(:name, :email, :subject, :body)
  end
end
