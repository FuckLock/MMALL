require 'rails_helper'
include Sorcery::Controller
include ActionController::Metal

RSpec.describe AddressesController, type: :controller do
  before do
    @user = User.create(email: '12345@qq.com', password: '123456', password_confirmation: '123456')
  end
  # let(:user) { create(:user) }
  describe ':new' do
    it 'render new template' do
      login(@user.email, '123456')
      get :new
      expect(response).to render_template(:new)
    end
  end
end
