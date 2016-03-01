class User < ActiveRecord::Base
	# has_secure_password

	has_many :given_coffees, class_name: :CoffeeGift, foreign_key: :giver_id
	has_many :received_coffees, class_name: :CoffeeGift, foreign_key: :receiver_id

	# validates_presence_of :email, :phone, :first_name, :last_name
	# validates_presence_of :username, :on => :save
	# validates_uniqueness_of :username, :email, :phone, :on => :save
	# validates_length_of :username, :email, maximum: 50, :on => :save
	# validates_length_of :phone, is: 10
	# validates_length_of :first_name, :last_name, maximum: 25
	# validates_email_format_of :email, message: "is not in the correct format"
	# validates_format_of :phone, with: /\d{10}/, message: "is not in the correct format"
	# validates :password, :presence => true, :length => {minimum: 6}, :on => :create

	before_save :extract_username, :set_names_based_on_provider

	def received_coffee?(coffee_gift)
		self == coffee_gift.receiver
	end

	def sent_coffee?(coffee_gift)
		self == coffee_gift.giver
	end

	def sent_or_received_coffee?(coffee_gift)
		self == coffee_gift.giver || self == coffee_gift.receiver
	end

	def unredeemed_coffee_gifts
		received_coffees.where(redeemed: false)
	end

	def redeemed_coffee_gifts
		received_coffees.where(redeemed: true)
	end

	def find_associated_coffees
		coffee_gift = CoffeeGift.find_by(phone: phone)
	  received_coffees << coffee_gift if coffee_gift
	end

	# def full_name
	# 	full_name ||= "#{first_name} #{last_name}"
	# end

	def combined_value
    "#{self.full_name} (#{self.username})"
  end

	def self.create_from_omniauth(auth)
		where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
			user.email = auth.info.email
			user.image_url = auth.info.image
      user.full_name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    end
	end

	private

	def extract_username
		self.username = self.email.split('@').first.downcase
	end

	def set_names_based_on_provider
		self.provider == 'facebook' ? set_first_last_names : set_full_name
	end

	def set_first_last_names
		name_arr = self.full_name.split(' ')
		self.last_name = name_arr.pop
		self.first_name = name_arr.join(' ')
	end

	def set_full_name
		self.full_name = self.first_name + self.last_name
	end

end
