class TransactionsController < ApplicationController
  before_action :find_menu_item
  skip_before_action :verify_authenticity_token, only: :create

  def new
    authenticate_user
    @coffee_gift = CoffeeGift.new
  end

  def create
    @coffee_gift = construct_coffee_gift
    if @coffee_gift.save
      create_stripe_charge
      flash[:notice] = "Success!"
      flash[:twilio_error] = TwilioTextSender.new(@coffee_gift).send!
      redirect_to confirmation_path(@coffee_gift)
    else
      redirect_to new_transaction_path
    end
  end

  private

  def authenticate_user
    unless current_user
      flash[:error] = ["Please login to send coffee."]
      redirect_to root_path
    end
  end

  def find_menu_item
    @menu_item = MenuItem.find_by(id: session[:menu_item_id])
    @cafe = @menu_item.cafe
    redirect_to root_path unless @menu_item
  end

  def construct_coffee_gift
    current_user.given_coffees.build(
      phone: params[:phone],
      message: params[:message],
      menu_item: @menu_item,
      receiver: User.find_by(phone: strip_special_chars_from_phone(params[:phone]))
    )
  end

  def create_stripe_charge
    Stripe.api_key = ENV['STRIPE_SECRET']
    begin
      charge = Stripe::Charge.create(
        :amount => @coffee_gift.stripe_price,
        :currency => "usd",
        :source => params[:stripeToken],
        :description => "COFFEEPAL, LLC"
        )
    rescue Stripe::CardError => e
      flash[:alert] = "An unexpected error has occured with your payment. Please try again."
      redirect_to new_transaction_path
    end
  end

	def strip_special_chars_from_phone(phone)
		phone.gsub(/\(|\)|-| /,'')
	end

end
