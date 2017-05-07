class BraintreeController < ApplicationController
  def new
    @reservation = Reservation.find(params[:rid])
  	@client_token = Braintree::ClientToken.generate
  end

  def checkout
	  nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

  	result = Braintree::Transaction.sale(
  		:amount => Reservation.find(params[:rid]).total_price,
   		:payment_method_nonce => nonce_from_the_client,
   		:options => { :submit_for_settlement => true }
   	)

 		if result.success?
      r = Reservation.find(params[:rid])
      r.update(confirm_status:true)
      ReservationMailer.booking_email(current_user,r.listing.user,r).deliver_now
    	redirect_to reservations_path,:success => "Transaction successful!" 
  	else
    	redirect_to payment_new_path, :danger => "Transaction failed. Please try again." 
  	end   	
  end
  
end