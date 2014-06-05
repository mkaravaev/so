class TagsController < InheritedResources::Base
  actions :index, :create
  before_action :authenticate_user!, except: [:index]

 protected

  def tag_params
    params.require(:tag).permit(:name, :question_id)
  end

end
