# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question_comment, class: Comment do
    body 'awsome comment body'
    user_id '1'
    commentable_type 'Question'
  end

  factory :answer_comment, class: Comment do
    body 'awsome comment body'
    user_id '1'
    commentable_type 'Answer'
  end
end
