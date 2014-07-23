class AnswerMailer < ActionMailer::Base
  default from: "from@example.com"

  def new_answer(answer)
    @answer = answer
    mail to: @answer.user.email
    # TODO fix @answer.question.user.email does not init question
  end
end
