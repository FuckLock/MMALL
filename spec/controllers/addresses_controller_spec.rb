require 'rails_helper'
include Sorcery::Controller

RSpec.describe AddressesController, type: :controller do
  let(:user) { create(:user) }
  let(:address) { create(:address, user_id: user.id) }

  describe ':new' do
    it 'render new template' do
      auto_login(user)
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe ':index' do
    it 'render index template' do
      auto_login(user)
      get :new
      expect(response).to render_template(:new)
    end
  end

  # describe ':create' do
  #   it 'render to string addresses_index' do
  #     auto_login(user)
  #     post :create, params: { address: { user_id: address.id, address_type: address.address_type,
  #                                        contact_name: address.contact_name,
  #                                        cellphone: address.cellphone, address: address.address,
  #                                        zipcode: address.zipcode, set_as_default: '1' } }
  #     expect(response).to
  #   end
  # end

  describe ':set_default_address' do
    it '' do
      auto_login(user)
      debugger
      put set_default_address_address_path
    end
  end
end
