class AnswersController < ApplicationController
  before_action :find_answer, only:[:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]

  def show
  end

  def new
    if user_signed_in?
      @answer = Answer.new
    else
      redirect_to new_user_session_path
    end
  end

  def edit
    unless user_signed_in?
      render(text: "page not found")
    end
  end

  def create
    @answer = Answer.create(answer_params)
    if user_signed_in? && @answer.errors.empty?
      redirect_to @answer
    else
      render :new
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to @answer
    else
      render :edit
    end
  end

  def destroy
    if user_signed_in?
      @answer.destroy
      redirect_to answers_path
    else  
      redirect_to new_user_session_path
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :question_id, :user_id)
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end

end
