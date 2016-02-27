class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :full_name, :string
    add_column :users, :oauth_token, :string
    add_column :users, :oauth_expires_at, :time
    add_column :users, :image_url, :string
  end
end
