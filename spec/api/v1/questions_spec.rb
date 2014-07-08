require 'spec_helper'

describe 'Question API' do
  describe 'GET Index' do
    context 'unauthorized' do
      it 'returns 401 status if no access_token' do
        get 'api/v1/questions', format: :json
        expect(response.status).to eq 401
      end

      it 'returns 401 status code if access_token invalid' do
        get 'api/v1/questions', format: :json
        expect(response.status).to eq 401
      end
    end

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

    context 'api/v1/questions/question_id' do
      let(:question) { create(:question) }
      let(:access_token) { create(:access_token) }
      let!(:comment) { create(:comment, commentable_id: question, commentable_type: question) }
      
      before do
        get 'api/v1/questions/' + "#{question.id}", format: :json, access_token: access_token.token
      end

      it 'should return propriate question' do
        expect(response.body).to be_json_eql(question)
      end

      %w(id title body created_at updated_at).each do |attr|
        it 'question object contains #{attr}' do
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("questions/#{question.id}/#{attr}")
        end
      end

      context 'question comments' do
        it 'include comments to question' do
          expect(response.body).to have_json_size(1).at_path("questions/0/comments")
        end

        %w(id body created_at updated_at).each do |attr|
          it 'question object contains #{attr}' do
            expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("questions/0/comments/0/#{attr}")
          end
        end

      end
    end
  end
end
