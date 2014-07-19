class AnswerMailer < ActionMailer::Base
  default from: "from@example.com"

  def new_answer(answer)
    @answer = answer
    mail to: @answer.question.user.email
  end
end
