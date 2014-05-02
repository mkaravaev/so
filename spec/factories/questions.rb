# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    title 'my_title'
    body 'my_example_body'
  end
  factory :invalid_question, class: "Question" do
    title ''
    body ''
  end
end
