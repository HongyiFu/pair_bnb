class ReservationsController < ApplicationController
	def create
		byebug
		@reservation = Listing.find(params[:listing_id]).reservations.new(reservation_params)
		@reservation.user = current_user
		byebug
		if @reservation.save
			redirect_to reservations_path, success:"Your reservation has been made."
		else 
			redirect_back_or listing_path, warning:"#{@reservation.errors.full_messages.join(". ")}."
		end
	end

	def reservation_params
		params.require(:reservation).permit(:start_date, :end_date)
	end

	def index
		@reservations = current_user.reservations
	end
end
