class CreateListingTags < ActiveRecord::Migration[5.0]
  def change
    create_table :listing_tags do |t|
      t.belongs_to :tag, index:true
      t.belongs_to :listing, index:true
      t.timestamps
    end
  end
end
