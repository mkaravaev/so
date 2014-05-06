require 'spec_helper'
require 'capybara/rspec'

describe AnswersController do
  let(:answer) { create(:answer) }
  let(:user) { create(:user) }
  describe 'GET #show' do

    before { get :show, id: answer }

    it 'puts appropriate answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it 'renderd show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do

    context 'if user signed in' do
      before  do 
        sign_in user
        get :new
      end

      it 'assigns new Answer to an @answer' do
        expect(assigns(:answer)).to be_a_new(Answer)
      end

      it 'renders new answer view' do
        expect(response).to render_template :new
      end
    end

    context 'if user not signed in' do
      it 'redirect to sign in page' do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end 
  end

  describe "GET #edit" do

    context 'user signed in' do
      before { sign_in user }
      before { get :edit, id: answer }

      it 'assigns appropriate answer to @answer' do 
        expect(assigns(:answer)).to eq answer
      end

      it 'renders edit view' do 
        expect(response).to render_template :edit
      end
    end

    context 'user not signed in' do
      before { get :edit, id: answer }
      it "redirect to sign in path" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "POST #create" do
    context 'user signed in' do
      before { sign_in user }
      it "saves new answer" do
        expect { post :create, answer: attributes_for(:answer) }.to change(Answer, :count).by(1)
      end

      it "redirect to show view" do
        post :create, answer: attributes_for(:answer)
        expect(response).to redirect_to answer_path(assigns(:answer))
      end
    end

    context 'user not signed in' do
      before { get :create, id: answer }
      it "redirect to sign in path" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "PATCH #update" do
    context "user signed in" do
      before { sign_in user }

      it 'assigns appropriate answer to @answer' do
        patch :update, id: answer, answer: attributes_for(:answer)
        expect(assigns(:answer)).to eq answer
      end

      it "changes answer attributes" do
        patch :update, id: answer, answer: { body: "my new body1" }
        answer.reload
        expect(answer.body).to eq "my new body1"
      end

      it "redirects to updated answers" do
        patch :update, id: answer, answer: attributes_for(:answer)
        expect(response).to redirect_to answer
      end
    end

    context  "user not signed in" do
      before { patch :update, id: answer }
      it "redirect to sign in path" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "DELETE #destroy" do

    context "user sign in" do
      before { sign_in user }
      before { answer }

      it "deletes answers" do
        expect { delete :destroy, id: answer }.to change(Answer, :count).by(-1)
      end
    
      it "redirect to index page" do
        delete :destroy, id: answer
        expect(response).to redirect_to answers_path
      end
    end

    context  "user not signed in" do
      before { patch :update, id: answer }
      it "redirect to sign in path" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

end
