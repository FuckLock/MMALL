# frozen_string_literal: true
# # frozen_string_literal: true

# require 'rails_helper'

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
# #
