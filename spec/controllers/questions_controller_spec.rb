require 'spec_helper'

describe QuestionsController do
  let(:question) { create(:question) }
  let(:user) { create(:user) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }
    before { get :index }

    it 'makes array with all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index page' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, id: question }

    it 'assigns appropriate question to @question' do
      expect(assigns(:question)).to eq question
    end

    it "build new Attachment for answer" do
      expect(assigns(:answer).attachments.first).to be_a_new(Attachment)
    end

    it 'assigns new answer for question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do

    context "when user signed in" do
      before { sign_in user }
      before { get :new }
      it "assigns new Question to a @question" do
        expect(assigns(:question)).to be_a_new(Question)  
      end

      it "build new Attachment for question" do
        expect(assigns(:question).attachments.first).to be_a_new(Attachment)
      end

      it "renders new view" do
        expect(response).to render_template :new
      end
    end

    context "when user not signed in" do
      before { get :new }
      it "redirect to user sign in page" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "GET #edit" do
    context "when user signed in" do
      before { sign_in user }
      before { get :edit, id: question }

      it 'assigns appropriate question to @question' do
        expect(assigns(:question)).to eq question
      end

      it "renders edit view" do
        expect(response).to render_template :edit
      end
    end

    context "when user not signed in" do
      before { get :edit, id: question }
      it "redirect to user sign in page" do
        expect(response).to redirect_to new_user_session_path
      end
    end  
  end

  describe "POST #create" do

    context "with signed in user" do
      before { sign_in user }

      context "with valid attriutes" do
        it "saves new question" do
          expect { post :create, question: attributes_for(:question) }.to change(user.questions, :count).by(1)
        end

        it "redirect to show view" do
          post :create, question: attributes_for(:question)
          expect(response).to redirect_to question_path(assigns(:question))
        end
      end

      context "with invalid attributes" do
        it "does not save the question" do
          expect { post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
        end
        it "re-renders new view" do
          post :create, question: attributes_for(:invalid_question)
          expect(response).to render_template :new
        end
      end
    end

    context 'user not signed in' do
      it 'redirects to sign in path' do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "PATCH #update" do

    context "if user sign in" do
      before { sign_in user}

      context "valid attributes" do
        
        it 'assigns appropriate question to @question' do
          patch :update, id: question, question: attributes_for(:question)
          expect(assigns(:question)).to eq question
        end

        it "changes question attributes" do
          patch :update, id: question, question: { title: "my_new_title1", body: "my new body1" }
          question.reload
          expect(question.title).to eq "my_new_title1"
          expect(question.body).to eq "my new body1"
        end

        it "redirects to updated questions" do
          patch :update, id: question, question: attributes_for(:question)
          expect(response).to redirect_to question
        end
      end

      context  "invalid attributes" do
        before { patch :update, id: question, question: { title: "my_new_title1", body: nil } }
        
        it "doesn't change question attriutes" do
          expect(question.title).to eq "my_title"
          expect(question.body).to eq "my_example_body"
        end

        it "renders edit template" do
          expect(response).to render_template :edit
        end
      end
    end

    context "if user not signed in" do
      before { patch :update, id: question }
      it 'redirects to sign in path' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "DELETE #destroy" do
    before { question }

    context "user is signed in" do
      before { sign_in user }
      
      it "deletes questions" do
        expect { delete :destroy, id: question }.to change(Question, :count).by(-1)
      end

      it "redirect to index page" do
        delete :destroy, id: question
        expect(response).to redirect_to questions_path
      end
    end

    context "if user not signed in" do
      it "redirects to sign in path" do
        delete :destroy, id: question
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
