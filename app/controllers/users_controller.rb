class UsersController < Clearance::UsersController

	def create
		current_params = user_params
		confirmed_password = current_params.delete(:password_confirmation)
		if current_params[:password] != confirmed_password
			redirect_to	sign_up_path, :danger => "Passwords do not match. Please try again." 
		else 
    	@user = User.new(current_params)
    	if @user.save
      	sign_in @user
      	redirect_back_or url_after_create
    	else
      	redirect_to	sign_up_path, danger:"#{@user.errors.full_messages.join(". ")}."
    	end
    end
  end

  def edit 
  	@user = User.find(params[:id])
  end

	# def show
	# 	@user = User.find(params[:id])
	# end

	private
	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :gender, :birthday, :phone_number, :country, :avatar)
	end

end
