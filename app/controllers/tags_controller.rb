class TagsController < ApplicationController
 before_action :authenticate_user!, except: [:index]

 def index
  @tags = Tag.all
  @tag = Tag.new
 end

 def create
  @tag = Tag.new(tag_params)
    unless @tag.save
      flash[:alert] = "Tag '#{@tag.name}' " + @tag.errors.messages[:name].to_s.gsub(/[^\w,\s,(!,?,.)]/, '')
    end
  redirect_to tags_path
 end

 private

  def tag_params
    params.require(:tag).permit(:name, :question_id)
  end

end
