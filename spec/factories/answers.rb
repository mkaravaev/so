# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    body 'this is the answer'
    question_id 2
  end
end
