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
    # debugger
    @address = current_user.addresses.new(address_attr)

    # if @address.save
    #   @addresses = current_user.reload.addresses
    #   render json: {
    #     status: 'ok',
    #     data: render_to_string(file: 'addresses/index')
    #   }
    # else
    #   render json: {
    #     status: 'error',
    #     data: render_to_string(file: 'addresses/new')
    #   }
    # end
    if @address.save
      redirect_to new_order_path
    end
  end

  def set_default_address
    # @address = current_user.addresses.find(params[:id])
    # @address.set_as_default = 1
    # @address.save!

    # @addresses = current_user.reload.addresses
    # render json: {
    #   status: 'ok',
    #   data: render_to_string(file: 'addresses/index')
    # }
    Address.where(address_value: 1).collect{|address| address.update_attributes!(address_value: 0)}
    
  end

  def destroy
    @address = current_user.addresses.find(params[:id])
    @address.destroy
    @addresses = current_user.addresses
    render json: {
      status: 'ok',
      data: render_to_string(file: 'addresses/index')
    }
  end

  private

  def address_attr
    params.require(:address).permit(:user_id, :address_type, :contact_name, :cellphone,
                                    :address, :zipcode, :set_as_default, :area, :address_value)
  end
end
