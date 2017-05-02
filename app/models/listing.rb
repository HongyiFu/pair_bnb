class Listing < ApplicationRecord
	belongs_to :user
	has_many :listing_tags
	has_many :tags, through: :listing_tags
	enum home_type: ["Entire home", "Private room", "Share room"]

	validates :description, presence:true
	validates :address, presence:true
	validates :city, presence:true
	validates :country, presence:true
	validates :price, presence:true
	validates :home_type, presence:true
end
