class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_atts)
    @user.uuid = session[:user_uuid] ? session[:user_uuid] : RandomCode.generate_utoken
    if @user.save
      UserMailer.send_email(@user)
      redirect_to register_success_path
    else
      render action: :new
    end
  end

  def register
    
  end

  private

  def user_atts
    params.require(:user).permit(:email, :password, :password_confirmation, :username, :phone_num, :question, :answer)
  end
end
