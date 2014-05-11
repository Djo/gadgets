FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email#{n}@factory.com" }
    password "strongpassword"
    password_confirmation "strongpassword"
  end
end
