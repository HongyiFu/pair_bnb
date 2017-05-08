class ListingsController < ApplicationController
	def index
		@listings = Listing.all 
	end

	def create
		@listing = current_user.listings.new(listing_params)
		if @listing.save
			redirect_to @listing, success:"Listing is added successfully."
		else 
			redirect_to new_listing_path, danger:"#{@listing.errors.full_messages.join(". ")}."
		end
	end

	def new
		if !signed_in? 
			redirect_to sign_in_path
		else  
			@listing = Listing.new
		end
	end

	def edit

	end

	def show
		@listing = Listing.find(params[:id])
		@reservation = Reservation.new
	end

	def update
	end

	def search
		byebug
		# @listing = Listing.all
		params.permit(:start_amount,:end_amount,:city,:num_of_bedroom,:num_of_bathroom)
		@listing = Listing.price_range(params[:start_amount],params[:end_amount]).contains_city(params[:city]).num_of_bedroom(params[:num_of_bedroom]).num_of_bathroom(params[:num_of_bathroom])
	end

	private
	def listing_params
		params.require(:listing).permit(:address, :city, :country, :price, :home_type , :description, :user_id, {tag_ids:[]}, {avatars: []}, {available_dates:[]})
	end

end
