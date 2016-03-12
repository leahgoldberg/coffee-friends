class RemovePictureFromCafes < ActiveRecord::Migration
  def change
    remove_column :cafes, :picture, :string
  end
end
