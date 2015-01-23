class QuestionsController < InheritedResources::Base
  before_action :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource
  before_action :build_attachment, only: :new
  before_action :build_tag, only: :new
  before_action :build_answer, only: :show
  
  respond_to :js, only: [:update]

  def subscribe
    resource.subscribe(current_user)
    redirect_to(resource)
  end

  def unsubscribe
    resource.unsubscribe(current_user)
    redirect_to(resource)
  end

  protected

  def create_resource(object)
    object.user = current_user
    super
  end

  def build_answer
    @answer = build_resource.answers.build
    @answer.attachments.build
  end

  def build_attachment
    build_resource.attachments.build
  end

  def build_tag
    build_resource.tags.build
  end

  def question_params
    params.require(:question).permit(:title, :tag_names, :body, :user_id, attachments_attributes: [:file, :id])
  end

end
