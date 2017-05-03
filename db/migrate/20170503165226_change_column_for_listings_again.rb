class ChangeColumnForListingsAgain < ActiveRecord::Migration[5.0]
  def change
  	remove_column :listings, :available_dates
  	add_column :listings, :available_dates, :date, array:true
  end
end
