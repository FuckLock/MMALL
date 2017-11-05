class SessionsController < ApplicationController
  def new
  end

  def create
    user = login(params[:username], params[:password])
    if user
      update_browser_uuid user.uuid
      redirect_to new_order_path and return if params[:rule] == "1"
      redirect_to shopping_carts_path and return if params[:rule] == "2"
      redirect_to root_path
    else
      if params[:email].blank?
        flash[:notice] = "用户名不能为空"
      elsif params[:password].blank?
        flash[:notice] = "密码不能为空"
      elsif params[:email].present? && params[:password].present?
        flash[:notice] = '用户名或者密码不正确'
      end
      redirect_to new_session_path
    end
  end

  # 忘记密码
  def pass_reset     
  end

  def create_next
    flash.now[:notice] = '请输入用户名' and render action: :pass_reset and return if params[:username].blank? 
    user = User.find_by(username: params[:username])
    flash.now[:notice] = '输入的用户名错误' and render action: :pass_reset and return unless user
    redirect_to next_reset_path(user_id: user)
  end

  def next_reset
    @user = User.find_by(id: params[:user_id])
  end

  def create_next_by_answer
    flash[:notice] = '请输入答案' and redirect_to next_reset_path(user_id: params[:user_id]) and return if params[:answer].blank?   
    flash[:notice] = '答案不正确' and redirect_to next_reset_path(user_id: params[:user_id]) and return if User.find_by(id: params[:user_id]).answer != params[:answer]  
    redirect_to submit_pass_path(user_id: params[:user_id])
  end

  def submit_pass
    @user = User.find_by(id: params[:user_id])
  end

  def create_submit
    # debugger
    flash[:notice] = '新密码不能为空' and redirect_to submit_pass_path(user_id: params[:user_id]) and return if params[:password].blank?
    User.find_by(id: params[:user_id]).update_attributes!(password: params[:password], password_confirmation: params[:password_confirmation])
    redirect_to reset_success_path
    rescue Exception => exception
      flash[:notice] = '密码不能少于6位' if params[:password].length < 6 ||  params[:password_confirmation] < 6 
      flash[:notice] = '密码不一致' if params[:password] != params[:password_confirmation]
      flash[:notice] = '确认密码不能为空' if params[:password_confirmation].blank?
      redirect_to submit_pass_path(user_id: params[:user_id])
  end

  def destroy
    logout
    redirect_to :back
  end
end
