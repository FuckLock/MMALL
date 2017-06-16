require 'rails_helper'

RSpec.describe User, type: :model do
  describe User do
    # debugger
    it { expect belongs_to(:default_address) }
  end
end
# frozen_string_literal: true
# # frozen_string_literal: true

# require 'rails_helper'

# feature 'user' do
#   given(:user) { FactoryGirl.create(:user, email: 'baodongdong@qq.com') }
#   scenario '#username' do
#     expect(user.username).to eq('baodongdong')
#   end

#   scenario '#need_validate_password' do
#     expect(user.need_validate_password).to be true
#   end
# end
