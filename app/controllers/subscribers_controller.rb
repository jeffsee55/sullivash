class SubscribersController < ApplicationController

  def create
    @subscriber = Subscriber.new(subscriber_params)
    if @subscriber.save
      redirect_to :back, notice: "Thank you for subscribing!"
    else
      redirect_to :back, notice: "There was a problem with your request. Please try again."
    end
  end

  def destroy
    @subscriber = Subscriber.find(params[:id])
    @subscriber.destroy
    redirect_to root_path, notice: "You've successfully unsubscribed."
  end

  private

    def subscriber_params
      params.require(:subscriber).permit(:email)
    end

end
