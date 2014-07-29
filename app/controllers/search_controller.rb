class SearchController < InheritedResources::Base
  actions :search, :show

  def search
    @questions = Question.search(params[:search])
  end

  protected

  # def search_params
  #   params.require(:search).permit(ser)
  # end
end
