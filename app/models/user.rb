class User < ApplicationRecord
  authenticates_with_sorcery!

  attr_accessor :username, :question, :answer, :password_confirmation, :phone_num
   
  validates_presence_of :username, message: "用户名不能为空"
  # validates :username, uniqueness: true
  validates_presence_of :password, message: '密码不能为空', if: :need_validate_password
  validates_length_of :password, message: '密码长度最少为6位', minimum: 6, if: :need_validate_password
  validates_presence_of :password_confirmation, message: '确认密码不能为空', if: :need_validate_password
  validates_confirmation_of :password, message: '密码不一致', if: :need_validate_password 
  validates_presence_of :phone_num, message: "不能为空"
  validates_format_of :phone_num, message: "号码格式不合法", with: /\A1[3|4|5|7|8][0-9]\d{8}\z/, on: :create
  validates_presence_of :email, message: "邮箱不能为空"
  validates_format_of :email, message: '邮箱格式不合法',
                              with: /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/,
                              if: proc { |user| !user.email.blank? }                                       
  validates_presence_of :question, message: "问题不能为空"
  validates_presence_of :answer, message: "答案不能为空"
 
  
  validates :email, uniqueness: true

  has_many :addresses, -> { where(address_type: Address::AddressType::USER).order('id desc') }
  belongs_to :default_address, class_name: :Address
  has_many :orders
  has_many :payments

  def need_validate_password
    new_record? || (password.present? || password_confirmation.present?)
  end
end
