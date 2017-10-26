class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_browser_uuid

  protected

  def set_browser_uuid
    uuid = cookies[:user_uuid]
    unless uuid
      uuid = if logged_in? && current_user.uuid
               current_user.uuid
             else
               RandomCode.generate_utoken
             end
    end
    update_browser_uuid uuid
  end

  def update_browser_uuid uuid
    session[:user_uuid] = cookies.permanent['user_uuid'] = uuid
  end

  def fetch_home_data
    @category = Category.where('ancestry is null')
    @categories = Category.grouped_data
    @shopping_cart_count = ShoppingCart.by_user_uuid(session[:user_uuid]).count
  end

  def auth_user
    return if logged_in?
    flash[:notice] = '请登录'
    redirect_to root_path
  end
end
