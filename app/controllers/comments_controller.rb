class CommentsController < InheritedResources::Base
  before_action :authenticate_user!
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
    # def set_commentable
  #   parent ||= %w{answer question}.find { |p| params.has_key?("#{p}_id")}
  #   @commentable ||= parent.classify.constantize.find(params["#{parent}_id"])
  # end
end
