class ChangeHomeTypesForListings < ActiveRecord::Migration[5.0]
  def change
  	change_column :listings, :home_type, 'integer USING CAST(home_type AS integer)'
  end
end
