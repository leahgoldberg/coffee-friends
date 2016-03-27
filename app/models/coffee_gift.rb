class CoffeeGift < ActiveRecord::Base
	belongs_to :menu_item
	belongs_to :receiver, class_name: :User
	belongs_to :giver, class_name: :User

	delegate :name, to: :menu_item
	delegate :cafe, to: :menu_item
	delegate :price, to: :menu_item

	before_save :generate_slug, :set_redemption_code

	validates_presence_of :menu_item
	validates_presence_of :phone, unless: Proc.new { |gift| gift.charitable }

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
end
