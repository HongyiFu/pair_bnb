class Reservation < ApplicationRecord
	belongs_to :user
	belongs_to :listing
	validates :start_date, presence: true
	validates :end_date, presence:true
	validate :start_date_before_end_date?
	# validate :available?
	# validate :overlap?

	def start_date_before_end_date?
		if self.start_date < self.end_date
			errors.add(:end_date, "can't be prior to start date.")
		end
	end

	def available?
		available_period_found = false
		self.listing.available_dates.each do |str|
			if str.include?("-")
				arr = str.split("-")
				start_date = Date.strptime(arr[0], '%d/%m/%Y')
				end_date = Date.strptime(arr[1], '%d/%m/%Y')
			else 
				start_date = Date.strptime(str, '%d/%m/%Y')
				end_date = Date.strptime(str, '%d/%m/%Y')
			end
			if start_date >= self.start_date && end_date <= self.end_date
				available_period_found = true
				break
			end
		end 
		if !available_period_found
			errors.add(:start_date, "or end date is not within available periods.")
		end
	end

	def overlap? 
		arr = self.listing.reservations 
		arr.each do |r|
			if r.start_date <= self.start_date && self.start_date >= r.end_date
				errors.add(:start_date, "is overlapped with another reservation.")
			elsif r.start_date <= self.end_date && self.end_date >= r.end_date
				errors.add(:end_date, "is overlapped with another reservation.")
			end
		end
	end

end
