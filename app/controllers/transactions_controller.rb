

class TransactionsController < ApplicationController
skip_before_action :verify_authenticity_token, only: :create

  def new
    @coffee_gift = CoffeeGift.find_by(id: session[:tmp_id])
    authenticate_user
    authorize_user
  end

  def create
    @coffee_gift = CoffeeGift.find_by(id: session[:tmp_id])

    # Set your secret key: remember to change this to your live secret key in production
    # See your keys here https://dashboard.stripe.com/account/apikeys
    Stripe.api_key = "sk_test_0mqxelCW5qHVbdH2GYG43467"

    # Get the credit card details submitted by the form
    token = params[:stripeToken]

    # Create the charge on Stripe's servers - this will charge the user's card
    begin
      charge = Stripe::Charge.create(
        :amount => (@coffee_gift.price*100).to_i, # amount in cents, again
        :currency => "usd",
        :source => token,
        :description => "COFFEEPAL.LLC"
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

end
