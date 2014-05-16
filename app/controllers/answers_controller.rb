class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_answer, only:[ :update ]

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params.merge({user_id: current_user.id}))

    respond_to do |format|
      format.html { redirect_to question_path(@question) }
      format.js
    end
  end

  def update
    @answer.update(answer_params)
    @question = @answer.question
  end

  # def destroy
  #   if user_signed_in?
  #     @answer.destroy
  #     redirect_to answers_path
  #   else  
  #     redirect_to new_user_session_path
  #   end
  # end

  private

  def answer_params
    params.require(:answer).permit(:body, :question_id, :user_id)
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end

end
