class CommentsController < InheritedResources::Base
  before_action :authenticate_user!
  load_and_authorize_resource
  actions :create
  belongs_to :question, :answer, polymorphic: true
  respond_to :js

  protected

  def comment_params
    params.require(:comment).permit(:body, :question_id, :user_id)
  end

  def create_resource(object)
    object.user = current_user
    super
  end

end
