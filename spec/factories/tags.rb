# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do
  factory :tag do
    sequence(:name) do |i|
      "rails on ruby #{i}"
    end
  end
end
