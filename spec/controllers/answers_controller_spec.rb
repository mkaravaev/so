require 'spec_helper'
require 'capybara/rspec'

describe AnswersController do

  let(:answer) { create(:answer) }
  let(:user) { create(:user) }
  let(:question) { create(:question) }

  # describe "GET #edit" do

  #   context 'user signed in' do
  #     before { sign_in user }
  #     before { get :edit, id: answer, question_id: question }

  #     it 'assigns appropriate answer to @answer' do 
  #       expect(assigns(:answer)).to eq answer
  #     end

  #     it 'renders edit view' do 
  #       expect(response).to render_template :edit
  #     end
  #   end

  #   context 'user not signed in' do
  #     before { get :edit, id: answer, question_id: question }
  #     it "redirect to sign in path" do
  #       expect(response).to redirect_to new_user_session_path
  #     end
  #   end
  # end

  describe "POST #create" do

    context 'user signed in' do
      before { sign_in user }
      context "with valid attributes" do
        it "saves new answer with valid attributes" do
          expect { post :create, answer: attributes_for(:answer), question_id: question }.to change(question.answers, :count).by(1)
        end

        it "redirect to question show view" do
          post :create, answer: attributes_for(:answer), question_id: question
          expect(response).to redirect_to question_path(question)
        end
      end

      context "with invalid attributes" do
        it "not save answer into database" do
         expect { post :create, answer: attributes_for(:invalid_answer), question_id: question }.to_not change(Answer, :count)
        end

        it "redirect to question show view " do
          post :create, answer: attributes_for(:invalid_answer), question_id: question
          expect(response).to redirect_to question_path(question)
        end
      end
    end

    context "user not signed in" do
      before { get :create, id: answer, question_id: question }
      it "redirect to sign in path" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  # describe "PATCH #update" do

  #   context "user signed in" do
  #     before { sign_in user }

  #     it 'assigns appropriate answer to @answer' do
  #       patch :update, id: answer, question_id: question, answer: attributes_for(:answer)
  #       expect(assigns(:answer)).to eq answer
  #     end

  #     it "changes answer attributes" do
  #       patch :update, id: answer, question_id: question, answer: { body: "my new body1" }
  #       answer.reload
  #       expect(answer.body).to eq "my new body1"
  #     end

  #     it "redirects to updated answers" do
  #       patch :update, id: answer, question_id: question, answer: attributes_for(:answer)
  #       expect(response).to redirect_to question_path(question)
  #     end
  #   end

  #   context  "user not signed in" do
  #     before { patch :update, id: answer, question_id: question }
  #     it "redirect to sign in path" do
  #       expect(response).to redirect_to new_user_session_path
  #     end
  #   end
  # end

  # describe "DELETE #destroy" do

  #   context "user sign in" do
  #     before { sign_in user }
  #     before { answer }

  #     it "deletes answers" do
  #       expect { delete :destroy, id: answer, question_id: question }.to change(Answer, :count).by(-1)
  #     end
    
  #     it "redirect to index page" do
  #       delete :destroy, id: answer, question_id: question
  #       expect(response).to redirect_to question_path(question)
  #     end
  #   end

  #   context  "user not signed in" do
  #     before { patch :update, id: answer, question_id: question }
  #     it "redirect to sign in path" do
  #       expect(response).to redirect_to new_user_session_path
  #     end
  #   end
  # end

end
