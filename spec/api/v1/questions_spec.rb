require 'spec_helper'

describe 'Question API' do

  describe 'GET#index' do
    it_behaves_like "API Authenticable"
    
    context 'authorized' do
      let!(:questions) { create_list(:question, 2) }
      let(:question) { questions.first }
      let(:access_token) { create(:access_token) }
      let!(:answer) { create(:answer, question: question) }

      before do
        get 'api/v1/questions', format: :json, access_token: access_token.token
      end

      it 'returns all question' do
        expect(response.body).to have_json_size(2).at_path('questions')
      end

      it 'contains timestamp' do
        expect(response.body).to be_json_eql(questions.last.created_at.to_json).at_path("meta/timestamp")
      end
      # to do add scope to last created question in Question model

      %w(id title body created_at updated_at).each do |attr|
        it 'question object contains #{attr}' do
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("questions/0/#{attr}")
        end
      end

      context 'answers' do
        it 'included in question object' do
          expect(response.body).to have_json_size(1).at_path("questions/0/answers")
        end

        %w(id body created_at updated_at).each do |attr|
          it 'question object contains #{attr}' do
            expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("questions/0/answers/0/#{attr}")
          end
        end
      end
    end

    def do_request(options={})
      get 'api/v1/questions', { format: :json }.merge(options)
    end
  end

  describe 'GET#show' do
    context 'api/v1/questions/question_id' do
      it_behaves_like "API GET#show" do
        let!(:object) { create(:question) }
        let!(:comment) { create(:question_comment, commentable_id: object.id) }
      end
    end

    def do_request(options={})
      get "api/v1/questions/#{object.id}", { format: :json }.merge(options)
    end
  end 

  describe "POST#create" do
    context 'user create question api/v1/questions' do

      let(:user) { create(:user) }
      let!(:question) { create(:question, user_id: user) }
      let(:access_token) { create(:access_token) }

      before do 
        post 'api/v1/questions', question: { title: question.title, body: question.body }, access_token: access_token.token, format: :json
      end

      it 'create question' do
        expect(response.status).to eq 201
      end

      it 'expect response to have question' do
        expect(response.body).to have_json_size(1)
      end

      %w(title body).each do |attr|
        it "created question contains #{attr}" do
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("question/#{attr}")
        end
      end
    end
  end
end
