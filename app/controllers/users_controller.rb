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
    redirect_to new_session_path and return unless logged_in?
    render action: :personal_center,layout: 'order'
  end

  def edit
    @user = current_user
    render action: :edit, layout: 'order'
  end

  def update
    current_user.update_attributes!(user_atts)
    render action: :personal_center, layout: 'order'
  end

  def edit_pass_update
    redirect_to new_session_path and return unless logged_in?
    render action: :edit_pass_update, layout: 'order'
  end

  def pass_update
    flash[:notice] = '请输入原始密码' and redirect_to edit_pass_update_path and return if params[:old_password].blank?
    flash[:notice] = '请输入正确的原始密码' and redirect_to edit_pass_update_path and return unless current_user.valid_password?(params[:old_password])
    flash[:notice] =  '新密码不能为空' and redirect_to edit_pass_update_path and return if params[:password].blank?
    flash[:notice] =  '确认密码不能为空' and redirect_to edit_pass_update_path and return if params[:password_confirmation].blank?
    flash[:notice] = '密码不能少于6位' and redirect_to edit_pass_update_path and return if params[:password].length < 6 || params[:password_confirmation].length  < 6
    flash[:notice] = '密码不一致' and redirect_to edit_pass_update_path and return if params[:password] != params[:password_confirmation]
    current_user.update_attributes!(password: params[:password], password_confirmation: params[:password_confirmation])
    flash.now[:notice] = '更新密码成功' and render aciton: :pass_update, layout: 'order'
  end

  private
  def user_atts
    params.require(:user).permit(:username, :password, :password_confirmation, :phone_num, :email, :question, :answer)
  end
end
