class CafesController < ApplicationController

  def index
    @cafes = Cafe.all
    if request.xhr?
      render @cafes
    else
      render :index
    end
  end

  def show
    @cafe = current_cafe || Cafe.find_by(slug: params[:id])
    @menu_item = MenuItem.new
    @menu_items = @cafe.menu_items
    @charitable_gifts = @cafe.unredeemed_charitable_gifts
    @unredeemed_coffee_gifts = @cafe.unredeemed_coffee_gifts
    if request.xhr?
      if params[:search] == ""
        @unredeemed_coffee_gifts = []
      else
        @unredeemed_coffee_gifts = @cafe.search_non_charitable_gifts(params[:search]).order("created_at DESC")
      end
      render partial: "unredeemed_coffee_gift", collection: @unredeemed_coffee_gifts
    end
  end

  def update
    @cafe = current_cafe
    if params[:cafe]
      @cafe.update_attributes(params[:cafe])
    else
      flash[:error] = ["Something went wrong! Your picture was not uploaded"]
    end
    render :show
  end

  def borough
    if request.xhr?
      @cafes = Cafe.filter_by_borough(params[:tag])
      render @cafes
    else
      @cafes = Cafe.all
      render :index
    end
  end

  def neighborhood
    if request.xhr?
      @cafes = Cafe.filter_by_neighborhood(params[:tag])
      render @cafes
    else
      @cafes = Cafe.all
      render :index
    end
  end

end



