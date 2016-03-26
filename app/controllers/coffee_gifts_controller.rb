class CoffeeGiftsController < ApplicationController

	before_action :authenticate_user, except: [:update, :filter, :confirm_redemption, :show, :redemption_confirmation]
	before_action :find_coffee_gift, only: [:update, :confirm, :show, :redemption_confirmation, :confirm_redemption]
	before_action :find_cafe, except: [:new, :create, :update, :redemption_confirmation, :confirm_redemption]

	def new
		if request.xhr?
			flash[:auth_error] = "Please login to send coffee." unless current_user
			@cafe = Cafe.find_by(id: params[:cafe_id])
		else
			@cafe = Cafe.find_by(slug: params[:cafe_id])
		end
		@menu_items = @cafe.menu_items
		@receivers = User.all
		@coffee_gift = CoffeeGift.new
		render :new, layout: !request.xhr?
	end

	def create
		if menu_item = MenuItem.find_by(id: params[:menu_item])
			session[:menu_item_id] = menu_item.id
			redirect_to new_transaction_path
		else
			redirect_to root_path
		end
	end

	def update
		if @coffee_gift.update_attributes(redeemed: true)
			flash[:notice] = "Coffee Redeemed!"
			TwilioTextSender.new(@coffee_gift).send!
			redirect_to redemption_confirmation_path
		else
			flash[:error] = ["Unable to redeem voucher"]
			redirect_to cafes_profile_path
		end
	end

	def redemption_confirmation
	end

	def show
	end

	def confirm_redemption
	end

	def confirm
	end

	private

	def find_coffee_gift
		@coffee_gift = CoffeeGift.find_by(redemption_code: params[:redemption_code]) || CoffeeGift.find_by(id: params[:id].split("-").first)
	end

	def find_cafe
		@cafe = @coffee_gift.cafe
	end

	def authorize_user
		find_coffee_gift
		redirect_to root_path unless current_user.sent_or_received_coffee?(@coffee_gift)
	end

	def authenticate_user
		unless current_user || request.xhr?
			flash[:error] = ["Please login to send coffee."]
			redirect_to root_path
		end
	end

end
