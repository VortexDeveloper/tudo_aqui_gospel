FactoryGirl.define do
  factory :announcer_payment do
    announcer ""
    ad ""
    price "9.99"
    payment_method 1
    charge_date "2017-03-03"
    paid_date "2017-03-03"
  end
end
