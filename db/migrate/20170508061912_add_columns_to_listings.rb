class AddColumnsToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :num_of_bedroom, :integer
    add_column :listings, :num_of_bathroom, :integer
  end
end
