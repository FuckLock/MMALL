class SessionsController < ApplicationController
  def new
  end

  def create
    user = login(params[:username], params[:password])
    if user
      update_browser_uuid user.uuid
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

  def passreset 
    render layout: false
    # if User.find_by(email: params[:email])
    #   redirect_to new_session_path
    # else
    #   if params[:email].blank?
    #     flash[:notice] = "用户名不能为空"
    #   elsif params[:email].present?
    #     flash[:notice] = "用户名不存在"
    #   end
    #   redirect_to passreset_path
    # end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
