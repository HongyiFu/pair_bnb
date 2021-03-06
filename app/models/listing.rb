class Listing < ApplicationRecord
	belongs_to :user
	has_many :listing_tags
	has_many :tags, through: :listing_tags
	has_many :reservations, dependent: :destroy
	enum home_type: ["Entire home", "Private room", "Share room"]

	validates :description, presence:true
	validates :address, presence:true
	validates :city, presence:true
	validates :country, presence:true
	validates :price, presence:true
	validates :home_type, presence:true
	validates :available_dates, presence:true
	# validate :check_dates_array
	mount_uploaders :avatars, AvatarUploader
	scope :price_range, -> (start_price,end_price){where(price:start_price..end_price)}
	scope :contains_city, -> (city){where("city ilike ?","%#{city}%")}
	scope :num_of_bedroom, -> (num){where(num_of_bedroom:num)}
	scope :num_of_bathroom, -> (num){where(num_of_bedroom:num)}
	# scope :tags, -> (tag_ids){
	# 	arr = Listing.none
	# 	return Listing.all if tag_ids == [] 
	# 	Listing.each do |l|
	# 		for
	# 	}

	# To check if there is even number of dates. 
	# If input recvd as ["date", ""], validation would fail.
	# If input recvd as ["start_date1", "end_date1", "start_date2", ""], validation would fail as well.
	# If input recvd as ["start_date", "end_date", "", ""], it means user added additional column, 
	# but did not use it. Validation would pass and additional empty strings will be deleted.
	def check_dates_array
		# check start-date end-date pair so that they appear together
		arr = self.available_dates
		arr.each_with_index do |d,i|
			if i % 2 == 0
				if d == nil 
					if arr[i+1] == nil
						arr.delete_at(i)
						arr.delete_at(i+1)
					else 
						errors.add(:available_dates,"are invalid. Start date and end date must both be present")
					end
				elsif arr[i+1] == nil
					errors.add(:available_dates,"are invalid. Start date and end date must both be present")
				end
			end
		end

		self.available_dates.delete(nil)
		if self.available_dates.count == 0
			errors.add(:available_dates,"must not be blank")
		end
	end

	def country_name
    country = ISO3166::Country[self.country]
    country.translations[I18n.locale.to_s] || country.name 
  end


end
