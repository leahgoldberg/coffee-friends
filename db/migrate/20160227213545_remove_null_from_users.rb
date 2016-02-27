class RemoveNullFromUsers < ActiveRecord::Migration
  def change
    change_column :users, :first_name, :string, null:true
    change_column :users, :last_name, :string, null:true
    change_column :users, :username, :string, null:true
    change_column :users, :email, :string, null:true
    change_column :users, :phone, :string, null:true
    change_column :users, :password_digest, :string, null:true
  end
end
