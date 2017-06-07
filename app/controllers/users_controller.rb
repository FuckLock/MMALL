class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_atts)
		@user.uuid = session[:user_uuid]
		if @user.save
			flash[:notice] = "注册用户成功, 请登录"
			redirect_to root_path
		else 
			flash[:notice] = "注册用户失败"
			render action: :new
		end
	end

	private
	def user_atts
		params.require(:user).permit(:email, :password, :password_confirmation)
	end

end
