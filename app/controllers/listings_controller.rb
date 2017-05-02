class ListingsController < ApplicationController
	def index
		@listings = Listing.all 
	end

	def create
		byebug
		param = listing_params
		param[:tag_ids] = param[:tag_ids][1..-1] if param[:tag_ids] != []
		byebug
		@listing = Listing.new(listing_params)
		if @listing.save
			redirect_to @listing, success:"Listing is added successfully."
		else 
			redirect_to new_listing_path, warning:"#{@listing.errors.full_messages.join(". ")}."
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
	end

	def update
	end

	private
	def listing_params
		params.require(:listing).permit(:address, :city, :country, :price, :home_type, :description, :user_id, :tag_ids => [])
	end

end
