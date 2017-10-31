class Address < ApplicationRecord
  validates :user_id, presence: true
  validates :address_type, presence: true
  validates :area, presence: {message: '所在地区不能为空'}
  validates :contact_name, presence: { message: '收货人不能为空' }
  validates :cellphone, presence: { message: '手机号不能为空' }
  validates :address, presence: { message: '详细地址不能为空' }

  scope :by_select_value, ->(select_value){ where(selected_value: select_value)}
  scope :by_address_value, ->(address_value){ where(address_value: address_value)}
  after_create :update_address

  belongs_to :user

  module AddressType
    USER = 'user'
    ORDER = 'order'
  end

  private
  def update_address
    self.update_attributes!(address_value: 1) unless Address.by_address_value(1).any?
  end
end
