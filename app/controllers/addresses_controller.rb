class AddressesController < ApplicationController
  before_action :auth_user
  layout false

  def new
    @address = current_user.addresses.new
    render_to_string(file: 'addresses/new')
  end

  def index
    @addresses = current_user.addresses
    render layout: false
  end

  def create
    @address = current_user.addresses.new(address_attr)
    if @address.save
      redirect_to new_order_path
    end
  end

  def edit
    if params[:id]
      @address = Address.find(params[:id])
      render partial: 'orders/new_address'
    else
      @address = Address.new
      render partial: 'orders/new_address'
    end
  end

  def update
    @address = Address.find params[:id]
    @address.update_attributes!(address_attr)
    redirect_to new_order_path
  end

  def update_params
    if params[:type] == "changeSelect"
      Address.where(selected_value: 1).collect{|address| address.update_attributes!(selected_value: 0) }
      Address.find(params[:id]).update_attributes!(selected_value: 1)
    else
      Address.where("address_value = 1 or selected_value = 1").collect{|address| address.update_attributes!(address_value: 0, selected_value: 0) }
      Address.find(params[:id]).update_attributes!(address_value: 1, selected_value: 1)
      @addresses = current_user.addresses
      render template: 'orders/new'
    end
  end

  def destroy
    @address = current_user.addresses.find(params[:id])
    @address.destroy
    # @addresses = current_user.addresses
    redirect_to new_order_path
  end

  private

  def address_attr
    params.require(:address).permit(:user_id, :address_type, :contact_name, :cellphone,
                                    :address, :zipcode, :set_as_default, :area, :address_value)
  end
end
