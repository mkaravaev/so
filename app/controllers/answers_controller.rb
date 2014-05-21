class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_answer, only: [:update, :destroy]

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params.merge({user_id: current_user.id}))
  end

  def update
    @answer.update(answer_params)
    @question = @answer.question
  end

  def destroy
    @answer.destroy
    redirect_to question_path(@answer.question)
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :question_id, :user_id, attachments_attributes: [:file])
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end
end
