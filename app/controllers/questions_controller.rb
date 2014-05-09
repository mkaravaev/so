class QuestionsController < ApplicationController
  before_action :find_question, only:[:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @questions = Question.order('created_at DESC')
  end

  def show
    @answer = @question.answers.build
  end

  def new
    if user_signed_in?
      @question = Question.new
    else
      redirect_to new_user_session_path
    end
  end

  def edit   
  end

  def create
    @question = Question.create(question_params)

    if @question.save
      redirect_to @question
      flash[:notice] = "Question created!"
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  private

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, :user_id)
  end
end
