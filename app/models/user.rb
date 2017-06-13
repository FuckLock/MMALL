# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!

  attr_accessor :password, :password_confirmation

  validates_presence_of :email, message: '邮件不能为空'
  validates_format_of :email, message: '邮箱格式不合法',
                              with: /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/,
                              if: proc { |user| !user.email.blank? }
  validates :email, uniqueness: true

  validates_presence_of :password, message: '密码不能为空',
                                   if: :need_validate_password
  validates_presence_of :password_confirmation, message: '确认密码不能为空',
                                                if: :need_validate_password
  validates_confirmation_of :password, message: '密码不一致',
                                       if: :need_validate_password
  validates_length_of :password, message: '密码长度最少为6位', minimum: 6,
                                 if: :need_validate_password

  has_many :addresses, -> { where(address_type: Address::AddressType::USER).order('id desc') }
  belongs_to :default_address, class_name: :Address
  has_many :orders
  has_many :payments

  def username
    email.split('@').first
  end

  def need_validate_password
    new_record? || (password.present? || password_confirmation.present?)
  end
end
