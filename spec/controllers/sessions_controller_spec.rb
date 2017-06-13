# frozen_string_literal: true

require 'rails_helper'
describe SessionsController, type: :controller do
  describe ':new' do
    it 'should render new template' do
      debugger
      get :new
      
      expect(response).to be_success
    end
  end

  describe ':create' do
    let (:user) { create(:user) }
    it 'should redirect to root_path' do
      post :create, params: { user: {email: user.email, password: user.password} }
      expect(response).to redirect_to(root_path)
    end
  end
end

# feature 'user' do
#   background do
#     # User.create(email: "123@qq.com", password: "123456", password_confirmation: "123456")
#     FactoryGirl.create(:user)
#   end

#   context 'user login' do
#     scenario 'user login success' do
#       visit new_session_path
#       within('form') dor
#         fill_in 'email', with: 'email1@factory.com'
#         fill_in 'password', with: '888888'
#         click_button '登录'
#       end
#       expect(page).to have_content '退出'
#     end
#     # given(:other_user) { User.create(email: 'other@example.com', password: 'rous')}
#     given(:other_user) { FactoryGirl.create(:user) }

#     scenario 'user login failed' do
#       visit new_session_path
#       within('form') do
#         fill_in 'email', with: other_user.email
#         fill_in 'password', with: other_user.password
#         click_button '登录'
#       end
#       expect(page).to have_content '登录'
#     end
#   end
# end
