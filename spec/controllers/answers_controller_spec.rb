require 'spec_helper'

describe AnswersController do
  let (:answer) { create(:answer) }

  describe "GET #index" do
    let(:answers) { create_list(:answer, 2) }
    before { get :index }

    it "puts all answers to @answers" do
      expect(assigns(:answers)).to match_array(answers)
    end

    it "renders index view" do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    before { get :show, id: answer }

    it "puts answer in @answer" do
      
    end

    it "renders show view" do
      
    end
  end

end
