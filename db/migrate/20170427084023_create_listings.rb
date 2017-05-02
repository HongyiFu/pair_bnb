class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.text :address
      t.string :city
      t.string :country
      t.numeric :price, precision: 10, scale: 2
      t.integer :home_type
      t.text :description
      t.references :user, foreign_key:true, index:true
      t.timestamps
    end
  end
end
