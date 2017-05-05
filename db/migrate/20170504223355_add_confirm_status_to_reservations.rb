class AddConfirmStatusToReservations < ActiveRecord::Migration[5.0]
  def change
    add_column :reservations, :confirm_status, :boolean, default:false
  end
end
