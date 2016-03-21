class TransactionsController < ApplicationController
  before_action :find_coffee_gift
  skip_before_action :verify_authenticity_token, only: :create

  def new
    authenticate_user
    authorize_user
  end

  def create
    Stripe.api_key = 'sk_test_0mqxelCW5qHVbdH2GYG43467'
    token = params[:stripeToken]
    begin
      charge = Stripe::Charge.create(
        :amount => @coffee_gift.stripe_price,
        :currency => "usd",
        :source => token,
        :description => "COFFEEPAL, LLC"
        )
    rescue Stripe::CardError => e
      # The card has been declined
    end
    flash[:notice] = "Success!"
    flash[:twilio_error] = TwilioTextSender.new(@coffee_gift).send!
    redirect_to confirmation_path(@coffee_gift)
  end

  private

  def authorize_user
    unless current_user.sent_or_received_coffee?(@coffee_gift)
      redirect_to root_path
    end
  end

  def authenticate_user
    unless current_user
      flash[:error] = ["Please login to send coffee."]
      redirect_to root_path
    end
  end

  def find_coffee_gift
    @coffee_gift = CoffeeGift.find_by(id: session[:tmp_id])
  end

end
