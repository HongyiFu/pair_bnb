class ReservationJob < ApplicationJob
  queue_as :default

  def perform(customer_id,host_id,reservation_id)
  	r = Reservation.find(reservation_id)
  	customer = User.find(customer_id)
  	host = User.find(host_id)
  	ReservationMailer.booking_email(customer,host,r).deliver_now
  end
end
