class ChangeGenderForUsers < ActiveRecord::Migration[5.0]
  def change
  	remove_column :users, :gender, :string
  	add_column :users, :gender, :integer, default:0
  end
end
