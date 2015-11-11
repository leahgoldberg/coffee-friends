class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: :User

  def self.search_all_users(search_term, current_user)
    User.where("first_name LIKE ? AND id <> ?", "#{search_term}%", current_user.id)
  end

end
