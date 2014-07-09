class Api::V1::QuestionsController < Api::V1::BaseController
  respond_to :json

  def index
    respond_with collection, meta: { timestamp: collection.last.created_at }
  end

  protected

  def create_resource(object)
    object.user = current_user
    super
  end
  
   def question_params
    params.require(:question).permit(:title, :tag_names, :body, :user_id, attachments_attributes: [:file, :id])
  end
end