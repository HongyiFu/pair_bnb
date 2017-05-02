class StaticController < ApplicationController
	def home 
		@listing = Listing.all.order('created_at DESC')
	end
end