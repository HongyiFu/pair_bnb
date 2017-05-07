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
		# purpose of first if: skip validation if blank dates
		if self.start_date
			if Reservation.find_by(id:self.id) == nil && self.start_date < Date.today + 2
				errors.add(:bookings, "must be done 2 days prior")
			end
		end
	end

	def start_date_before_end_date?
		# purpose of first if: skip validation if blank dates
		if self.start_date && self.end_date
			if Reservation.find_by(id:self.id) == nil && self.start_date > self.end_date
				errors.add(:end_date, "can't be prior to start date")
			end
		end
	end

	def available?
		# purpose of first if: skip validation if blank dates
		if self.start_date && self.end_date
			available_period_found = false
			self.listing.available_dates.each_with_index do |d,i|
				if i%2 == 0
					start_date = d
					end_date = self.listing.available_dates[i+1]
					if self.start_date >= start_date && self.end_date <= end_date
						available_period_found = true
						break
					end
				end
			end 
			if !available_period_found
				errors.add(:booking_period, "is not within available periods")
			end
		end
	end

	def overlap? 
		# purpose of first if: skip validation if blank dates
		if self.start_date && self.end_date
			arr = self.listing.reservations.order('start_date')

			# to exclude self - so validation will not be triggered during update of attributes
			arr = arr - [self]

			arr.each do |r|
				if r.start_date == self.start_date || r.end_date == self.start_date 
					errors.add(:start_date, "is overlapped with another reservation")
				elsif r.end_date == self.end_date || r.start_date == self.end_date
					errors.add(:end_date, "is overlapped with another reservation")
				elsif r.start_date < self.start_date && self.start_date < r.end_date
					errors.add(:start_date, "is overlapped with another reservation")
				elsif r.start_date < self.end_date && self.end_date < r.end_date
					errors.add(:end_date, "is overlapped with another reservation")
				end
			end
	
		end
	end

	def total_price
		price = self.listing.price
		days = (self.end_date - self.start_date)
		days = 1 if days == 0 
		price *= days
	end

end
