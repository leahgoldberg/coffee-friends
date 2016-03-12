class AddImageUrlToCafes < ActiveRecord::Migration
  def change
    add_column :cafes, :image_url, :string
  end
end
