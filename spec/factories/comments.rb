# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    body 'awsome comment body'
    user_id '1'
    commentable_type 'Question'
  end
end
