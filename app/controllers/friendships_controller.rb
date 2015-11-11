class FriendshipsController < ApplicationController

  def index
    if request.xhr?
      @friends = []
      @friends = Friendship.search_all_users(params[:search], current_user) unless params[:search].blank?
      render partial: "friend", collection: @friends, layout: false
    end
  end  

  def show
    @friends = current_user.friends
  end  

  def new
    @friendship = Friendship.new
  end  

end  