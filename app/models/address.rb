# frozen_string_literal: true

class Address < ApplicationRecord
  validates :user_id, presence: true
  validates :address_type, presence: true
  validates :area, presence: {message: '所在地区不能为空'}
  validates :contact_name, presence: { message: '收货人不能为空' }
  validates :cellphone, presence: { message: '手机号不能为空' }
  validates :address, presence: { message: '详细地址不能为空' }

  # attr_accessor :set_as_default
  # after_save :set_as_default_address

  belongs_to :user

  module AddressType
    USER = 'user'
    ORDER = 'order'
  end

  # private

  # def set_as_default_address
  #   if set_as_default.to_i == 1
  #     user.default_address = self
  #     user.save!
  #   else
  #     remove_as_default_address
  #   end
  # end

  # def remove_as_default_address
  #   return unless user.default_address == self
  #   user.default_address = nil
  #   user.save!
  # end
end
