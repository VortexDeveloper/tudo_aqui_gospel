FactoryGirl.define do
  factory :transaction do
    user nil
    subscription_plan nil
    status 1
    subscription_code "MyString"
  end
end
