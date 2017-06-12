# frozen_string_literal: true

require 'simplecov'
SimpleCov.profiles.define 'myprofile' do
  load_profile 'rails'
  add_filter '/test/'
  add_filter '/config/'
  add_filter '/channels'
  add_filter '/lib/simplecov_custom_profile.rb'
  add_filter '/helpers/'
  add_filter '/jobs/'
  add_filter '/mailers/'

  add_group 'Controllers', 'app/controllers'
  add_group 'Models', 'app/models'
end
