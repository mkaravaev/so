class AnswerMailer < ActionMailer::Base
  default from: "from@example.com"

  def new_answer(answer)
    @answer = answer
    mail to: @answer.question.user.email
    # TODO fix @answer.question.user.email does not init question
  end

  def subscriber_new_answer(answer)
    @answer = answer
    @answer.question.subscribers.find_each do |i|
    mail to: i.email
  end
end
