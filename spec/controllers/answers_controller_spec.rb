require 'spec_helper'
require 'capybara/rspec'

describe AnswersController do

  let(:user) { create(:user) }
  let!(:question) { create(:question) }
  let!(:answer) { create(:answer, question_id: question.id, user_id: user.id) }

  describe "POST #create" do

    context 'user signed in' do
      before { sign_in user }

      context "with valid attributes" do
        it "saves new answer with valid attributes" do
          expect { post :create, answer: attributes_for(:answer), question_id: question, format: :js }.to change(question.answers, :count).by(1)
        end

        it "render create template" do
          post :create, answer: attributes_for(:answer), question_id: question, format: :js
          expect(response).to render_template :create
        end
      end

      context "with invalid attributes" do
        it "not save answer into database" do
         expect { post :create, answer: attributes_for(:invalid_answer), question_id: question, format: :js }.to_not change(Answer, :count)
        end
      end
    end

    context "if user not signed in " do
      before { get :create, id: answer, question_id: question, format: :js }
      it "gets 401 error" do
        expect(response.code).to eq "401"
      end
    end
  end


  describe "PATCH #update" do
    let(:answer) { create(:answer, question: question) }
    context "user signed in" do
      before { sign_in user }

      it "assigns appropriate answer to @answer" do
        patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
        expect(assigns(:answer)).to eq answer
      end

      it "changes answer attributes" do
        patch :update, id: answer, question_id: question, answer: { body: "new body11" }, format: :js
        answer.reload
        expect(answer.body).to eq "new body11"
      end

      it "assigns question variable" do
        patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
        expect(assigns(:question )).to eq question
      end

      it "renders update template" do
        patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
        expect(response).to render_template :update
      end
    end

    context "user not signed in" do
      before { patch :update, id: answer, question_id: question }
      it "redirect to sign in path" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end


  describe "DELETE #destroy" do

    context "user sign in" do
      before { sign_in user }

      it "deletes answers" do
        expect { delete :destroy, id: answer, question_id: question.id }.to change(Answer, :count).by(-1)
      end
    
      it "redirect to index page" do
        delete :destroy, id: answer, question_id: question.id
        expect(response).to redirect_to question_path(question)
      end
    end

    context  "user not signed in" do
      before { delete :destroy, id: answer, question_id: question }
      it "redirect to sign in path" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
