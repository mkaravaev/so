class QuestionsController < ApplicationController
  
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_question, only: [:show, :edit, :update, :destroy]
  

  def index
    @questions = Question.all
  end

  def show
    @question.tags.build
    @answer = @question.answers.build
    @answer.attachments.build
    @user = current_user
  end

  def new
    @question = Question.new
    @question.attachments.build
    @question.tags.build
  end

  def edit

  end

  def create
    @question = current_user.questions.new(question_params)
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
    @question = Question.includes(:tags, :answers).find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :tag_names, :body, :user_id, attachments_attributes: [:file], tags_attributes: [:name])
  end
end
