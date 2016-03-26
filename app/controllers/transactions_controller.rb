class TransactionsController < ApplicationController
  before_action :find_menu_item
  skip_before_action :verify_authenticity_token, only: :create

  def new
    authenticate_user
    # authorize_user
    @coffee_gift = CoffeeGift.new
  end

  def create
    @coffee_gift = current_user.given_coffees.build(message: params[:message], menu_item: @menu_item)
    @coffee_gift.assign_phone(params)
    Stripe.api_key = 'sk_test_0mqxelCW5qHVbdH2GYG43467'
    token = params[:stripeToken]
    binding.pry
    if @coffee_gift.save
      begin
        charge = Stripe::Charge.create(
          :amount => @coffee_gift.stripe_price,
          :currency => "usd",
          :source => token,
          :description => "COFFEEPAL, LLC"
          )
      rescue Stripe::CardError => e
        redirect_to transactions_path
      end
    else
      redirect_to transactions_path
    end
    flash[:notice] = "Success!"
    flash[:twilio_error] = TwilioTextSender.new(@coffee_gift).send!
    redirect_to confirmation_path(@coffee_gift)
  end

  private

  # def authorize_user
  #   unless current_user.sent_or_received_coffee?(@coffee_gift)
  #     redirect_to root_path
  #   end
  # end

  def authenticate_user
    unless current_user
      flash[:error] = ["Please login to send coffee."]
      redirect_to root_path
    end
  end

  def find_menu_item
    @menu_item = MenuItem.find_by(id: session[:menu_item_id])
    @cafe = @menu_item.cafe
  end
end
