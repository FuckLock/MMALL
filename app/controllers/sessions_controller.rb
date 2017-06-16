class SessionsController < ApplicationController
  def new
    # render layout: false
  end

  def create
    debugger
    user = login(params[:email], params[:password])
    if user
      update_browser_uuid user.uuid
      flash[:notice] = '登录成功'
      redirect_to root_path
    else
      flash[:notice] = '邮箱或者密码不正确'
      redirect_to new_session_path
    end
  end

  def destroy
    logout
    flash[:notice] = '退出成功'
    redirect_to root_path
  end
end
