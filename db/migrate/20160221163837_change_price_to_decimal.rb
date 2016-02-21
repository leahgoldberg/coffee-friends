class ChangePriceToDecimal < ActiveRecord::Migration
  def change
    change_column :menu_items, :price, :decimal
  end
end
