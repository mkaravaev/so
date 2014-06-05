class AnswersController < InheritedResources::Base
  before_action :authenticate_user!
  actions :create, :update, :destroy
  respond_to :json, :js

  belongs_to :question
  
  def create
    create! do |success, failure|
      success.json
      failure.json { render json: resource.errors.full_messages, status: :unprocessable_entity }
    end
  end

  protected

  def create_resource(object)
    object.user = current_user
    super
  end

  def answer_params
    params.require(:answer).permit(:body, :question_id, :user_id, attachments_attributes: [:file, :id])
  end
end
