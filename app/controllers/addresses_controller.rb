# frozen_string_literal: true

class AddressesController < ApplicationController
  before_action :auth_user
  layout false

  def new
    @address = current_user.addresses.new
    render layout: false
  end

  def index
    @addresses = current_user.addresses
    render layout: false
  end

  def create
    @address = current_user.addresses.new(address_attr)

    if @address.save
      @addresses = current_user.reload.addresses
      render json: {
        status: 'ok',
        data: render_to_string(file: 'addresses/index')
      }
    else
      render json: {
        status: 'error',
        data: render_to_string(file: 'addresses/new')
      }
    end
  end

  def set_default_address
    @address = current_user.addresses.find(params[:id])
    @address.set_as_default = 1
    @address.save!

    @addresses = current_user.reload.addresses
    render json: {
      status: 'ok',
      data: render_to_string(file: 'addresses/index')
    }
  end

  def destroy
    @address = current_user.addresses.find(params[:id])
    @address.destroy
    render json: {
      status: 'ok',
      data: render_to_string(file: 'addresses/index')
    }
    layout false
  end

  private

  def address_attr
    params.require(:address).permit(:user_id, :address_type, :contact_name, :cellphone,
                                    :address, :zipcode, :set_as_default)
  end
end
