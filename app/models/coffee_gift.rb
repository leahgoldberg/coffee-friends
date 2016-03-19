class CoffeeGift < ActiveRecord::Base
	belongs_to :menu_item
	belongs_to :receiver, class_name: :User
	belongs_to :giver, class_name: :User

	delegate :name, to: :menu_item
	delegate :cafe, to: :menu_item
	delegate :price, to: :menu_item

	before_validation :strip_special_chars_from_phone
	before_save :generate_slug, :set_redemption_code

	validates_presence_of :menu_item
	validates_presence_of :phone, unless: Proc.new { |gift| gift.charitable }

	def assign_phone(params)
		self.menu_item = MenuItem.find_by(id: params[:menu_item])
		self.receiver = User.find_by(id: params[:receiver]) || User.find_by(phone: params[:phone])
		self.phone = self.receiver.phone if self.phone.blank? && self.receiver
	end

	def to_param
		"#{self.id}-#{slug}"
	end

	def stripe_price
		(price * 100).to_i
	end

	private

	def set_redemption_code
		code = rand(36**8).to_s(36)
		if CoffeeGift.find_by(redemption_code: code)
			set_redemption_code
		else
			self.redemption_code = code
		end
	end

	def generate_slug
		self.slug = self.name.parameterize
	end

	def strip_special_chars_from_phone
		self.phone = self.phone.gsub(/\(|\)|-| /,'')
	end

end
