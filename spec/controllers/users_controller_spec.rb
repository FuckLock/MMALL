require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe ':new' do
    it 'render new_user_path' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe ':create' do
    it 'render root_path' do
      post :create, params: { user: { email: 'email5@factory.com',
                                      password: '666666', password_confirmation: '666666' } }
      expect(response).to redirect_to(root_path)
    end

    it 'render new_user_path' do
      post :create, params: { user: { email: 'email6@factory.com',
                                      password: '666666', password_confirmation: '6666' } }
      expect(response).to render_template(:new)
    end
  end
end

# feature 'user register' do
#   scenario 'user register success' do
#     visit new_user_path
#     fill_in 'user[email]', with: '123@qq.com'
#     fill_in 'user[password]', with: '123456'
#     fill_in 'user[password_confirmation]', with: '123456'
#     click_button '创建用户'
#     visit root_path
#   end

#   scenario 'user register failed' do
#     visit new_user_path
#     fill_in 'user[email]', with: '123@qq.com'
#     click_button '创建用户'
#     visit new_user_path
#   end
# end
