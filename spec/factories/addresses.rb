FactoryGirl.define do
  factory :address, aliases: [:new_address] do
    sequence(:id, &:to_s)
    address_type 'user'
    contact_name '张三丰'
    cellphone '18810855258'
    address '北京市海淀区'
    zipcode '000000'
    association :user
  end

  factory :order_address, parent: :address do
    address_type 'order'
  end
end
