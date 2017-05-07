class ReservationMailer < ApplicationMailer

	def booking_email(customer, host, reservation)
		@customer = customer
		@host = host
		@url = listing_reservation_url(reservation.listing, reservation)
		email_with_name = %("#{@host.first_name}" <#{@host.email}>)
		mail(to: email_with_name, subject:"Notification of Confirmed Booking for Your Listing in #{reservation.listing.city}")
	end

end
