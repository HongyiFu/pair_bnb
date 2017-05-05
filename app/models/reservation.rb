class Reservation < ApplicationRecord
	belongs_to :user
	belongs_to :listing
	validates :start_date, presence: true
	validates :end_date, presence:true
	validate :start_date_before_today? 
	validate :start_date_before_end_date?
	validate :available?
	validate :overlap?

	def start_date_before_today? 
		if Reservation.find_by(id:self.id) == nil && self.start_date < Date.today
			errors.add(:start_date, "is earlier than current date.")
		end
	end

	def start_date_before_end_date?
		if Reservation.find_by(id:self.id) == nil && self.start_date < self.end_date
			errors.add(:end_date, "can't be prior to start date.")
		end
	end

	def available?
		available_period_found = false
		self.listing.available_dates.each_with_index do |d,i|
			if i%2 == 0
				start_date = d
				end_date = self.listing.available_dates[i+1]
				if start_date >= self.start_date && end_date <= self.end_date
					available_period_found = true
					break
				end
			end
		end 
		if !available_period_found
			errors.add(:booking_period, "is not within available periods.")
		end
	end

	def overlap? 
		arr = self.listing.reservations.order('start_date')
		arr2 = self.listing.reservations.where({id:self.id})
		arr = arr - arr2 #to exclude self
		arr.each do |r|
			if r.start_date == self.start_date || r.end_date == self.start_date 
				errors.add(:start_date, "is overlapped with another reservation.")
			elsif r.end_date == self.end_date || r.start_date == self.end_date
				errors.add(:end_date, "is overlapped with another reservation.")
			elsif r.start_date > self.start_date && self.start_date > r.end_date
				errors.add(:start_date, "is overlapped with another reservation.")
			elsif r.start_date > self.end_date && self.end_date > r.end_date
				errors.add(:end_date, "is overlapped with another reservation.")
			end
		end
	end

	def total_price
		price = self.listing.price
		days = (self.start_date - self.end_date)
		days = 1 if days == 0 
		price *= days
	end

end
