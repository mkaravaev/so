# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    body 'awsome comment body'
    commentable_id '2'
    commentable_type 'Question'
  end
end
