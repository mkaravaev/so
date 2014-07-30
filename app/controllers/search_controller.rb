class SearchController < InheritedResources::Base
  actions :search, :show

  def search
    collection
  end

  protected

    def collection
      @results = Question.search(params[:search])
    end

end
