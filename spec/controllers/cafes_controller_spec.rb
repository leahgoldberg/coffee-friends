require 'rails_helper'

describe CafesController do

  describe 'GET #index' do
    context 'cafe index page' do

      before :each do
        get :index
      end

      it 'assigns all cafes to @cafes' do
        expect(assigns(:cafes)).to eq(Cafe.all)
      end

      it 'renders the correct page' do
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #show' do
    context 'shows a particular cafe' do

      def assign_show_items
        @new_cafe = FactoryGirl.create(:cafe)
        @menu_item = FactoryGirl.create(:menu_item)
        @menu_items = @new_cafe.menu_items.create(FactoryGirl.attributes_for(:menu_item))
        get :show, id: @new_cafe
      end  

      it 'assigns the correct cafe to @cafe' do
        assign_show_items
        expect(assigns(:cafe)).to eq(@new_cafe)
      end

      it 'assigns a new menu item to @menu_item' do
        assign_show_items
        expect(assigns(:menu_item)).to be_a(MenuItem)
      end

      it 'assigns a cafes menu items to @menu_items' do
        assign_show_items
        expect(assigns(:menu_items)).to eq(@new_cafe.menu_items)
      end

      it 'renders the correct page' do
        assign_show_items
        expect(response).to render_template('show')
      end
    end
  end

  describe 'GET #borough' do
    pending
  end

  describe 'GET #neighborhood' do
    pending
  end
end
