class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: :User

  def search_all_users(current_user)
    User.where("id <> ?", current_user.id)
  end

end
