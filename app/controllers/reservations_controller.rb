class ReservationsController < ApplicationController
	def create
		listing = Listing.find(params[:listing_id])
		@reservation = listing.reservations.new(reservation_params)
		@reservation.user = current_user
		if @reservation.save
			redirect_to reservations_path, success:"Your reservation has been made."
		else 
			flash[:danger] = "#{@reservation.errors.full_messages.join(". ")}."
			redirect_back_or listing_path(listing)
		end
	end

	def reservation_params
		params.require(:reservation).permit(:start_date, :end_date)
	end

	def index
		@reservations = current_user.reservations
	end
end
