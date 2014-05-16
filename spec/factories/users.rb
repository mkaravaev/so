# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    password "example_foobar"
    password_confirmation "example_foobar"
    name "chypakabra"
    sequence(:email) do |i|
      "example#{i}@gmail.com"
    end
  end
end
