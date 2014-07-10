class Api::V1::AnswersController < Api::V1::BaseController
  respond_to :json

  def index
    respond_with collection, meta: { timestamp: collection.last.created_at }
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