class TwilioTextSender

	def initialize(coffee_gift)
		@coffee_gift = coffee_gift
		@account_sid = ENV["twilio_account_sid"]
		@auth_token = ENV["twilio_auth_token"]
	end

	def send!
		@coffee_gift.redeemed ? send_text(redeem_message) : send_text(receive_message)
	end

	private

	def configure_client
		Twilio.configure do |config|
			config.account_sid = @account_sid
			config.auth_token = @auth_token
		end
		@client = Twilio::REST::Client.new
	end

	def send_text(text_body)
		configure_client
		begin
			@client.account.messages.create({
				from: ENV["twilio_phone"],
				to: @coffee_gift.phone,
				body: text_body
				})
				return nil
			rescue Twilio::REST::RequestError => e
				puts "ERROR: #{e.message}"
				return "Sorry! Something went wrong on our end and we were unable to send a notification SMS. Please let your friend know where to pick up their coffee!"
			end
		end

		def receive_message
			if @coffee_gift.message.length > 1
				"You received a coffee at #{@coffee_gift.cafe.name} from #{@coffee_gift.giver.first_name} with the message: \"#{@coffee_gift.message}\" Visit http://coffeefriends.herokuapp.com to redeem."
			else
				"You received a coffee at #{@coffee_gift.cafe.name} from #{@coffee_gift.giver.first_name}! Visit http://coffeefriends.herokuapp.com to redeem."
			end
		end

		def redeem_message
			"Your coffee has been redeemed! Do something nice and maybe someone will buy you another one."
		end

end
