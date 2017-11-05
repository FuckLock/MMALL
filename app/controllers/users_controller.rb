class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_atts)
    @user.uuid = RandomCode.generate_utoken
    if @user.save
      UserMailer.send_email(@user)
      redirect_to register_success_path
    else
      render action: :new
    end
  end

  def register
    
  end

  def personal_center
    render action: :personal_center,layout: 'home'
  end

  private

  def user_atts
    params.require(:user).permit(:username, :password, :password_confirmation, :phone_num, :email, :question, :answer)
  end
end
