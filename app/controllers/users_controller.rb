require 'byebug'

class UsersController < Clearance::UsersController

	# def index
	# 	@users = User.all 
	# end

	def create
		current_params = user_params
		confirmed_password = current_params.delete(:password_confirmation)
		if current_params[:password] != confirmed_password
			flash[:password] = "do not match." 
			redirect_to	sign_up_path
		else 
    	@user = User.new(current_params)
    	if @user.save
      	sign_in @user
      	redirect_back_or url_after_create
    	else
    		flash[:sign_up_info] = "bad info!"
      	redirect_to	sign_up_path
    	end
    end
  end

  def edit 
  	@user = User.find(params[:id])
  end

	# def create
	# 	@user = User.new(user_params)
	# 	if @user.save
	# 		redirect_to @user
	# 	else
	# 		redirect_to 'static#home'
	# 	end
	# end

	# def show
	# 	@user = User.find(params[:id])
	# end

	private
	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :gender, :birthday, :phone_number, :country)
	end

end
