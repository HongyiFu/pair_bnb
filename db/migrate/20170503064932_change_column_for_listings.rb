class ChangeColumnForListings < ActiveRecord::Migration[5.0]
  def change
  	change_column :listings, :available_dates, :text, array:true
  end
end
