class FriendshipsController < ApplicationController

  def index
    @friends = current_user.friends
  end  

  def new
    @friends = User.all
  end  

end  