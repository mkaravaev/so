require 'spec_helper'

describe "Answers API" do 
  describe 'GET#Index' do

    let(:question) { create(:question) }
    let!(:answers_list) { create_list(:answer, 2, question_id: question) }
    let!(:answer) { answers_list.first }

    context 'unauthorized' do
      it 'returns 401 status if no access_token' do
        get "api/v1/questions/#{question.id}/answers", format: :json
        expect(response.status).to eq 401
      end

      it 'returns 401 status code if access_token invalid' do
        get "api/v1/questions/#{question.id}/answers", format: :json
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:access_token) { create(:access_token) }

      before do
        get "api/v1/questions/#{question.id}/answers", format: :json, access_token: access_token.token
      end

      it 'contains all answers' do
        expect(response.body).to have_json_size(2)
      end

      %w(id body created_at updated_at).each do |attr|
        it 'question object contains #{attr}' do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("answers/0/#{attr}")
        end
      end
    end
  end

  describe "GET#show" do

    let(:question) { create(:question) }
    let!(:answer) { create(:answer, question_id: question) }
    let(:comment) { create(:answer_comment, commentable_id: answer.id )}
    let(:access_token) { create(:access_token) }

    before do
      get "api/v1/questions/#{question.id}/answers/#{answer.id}", format: :json, access_token: access_token.token
    end

    it "returns 200 status code" do
      expect(response.status).to eq 200
    end

    %w(id body created_at updated_at).each do |attr|
      it 'answer object contains #{attr}' do
        expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("answer/#{attr}")
      end
    end
  end
end