class SearchController < InheritedResources::Base
  actions :search, :show

  def search
    collection
  end

  protected

    def collection
      @rusults = Question.search(params[:search])
    end

end
