require 'spec_helper'

describe QuestionsController do
  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }
    
    before do
      get :index
    end

    it 'makes array with all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'should generates index page' do
      expect(response).to render_template :index
    end
  end
end
