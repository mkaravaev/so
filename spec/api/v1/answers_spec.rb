require 'spec_helper'

describe "Answers API" do 
  let(:question) { create(:question) }
  describe 'GET#Index' do
    
    let(:question) { create(:question) }
    let!(:answers_list) { create_list(:answer, 2, question: question) }
    let!(:answer) { answers_list.first }

    it_behaves_like "API Authenticable"

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

    def do_request(options = {})
      get "api/v1/questions/#{question.id}/answers", { format: :json }.merge(options)
    end
  end

  describe "GET#show" do
    it_behaves_like "API GET#show" do
      let!(:question) { create(:question) }
      let!(:object) { create(:answer, question: question) }
      let!(:comment) { create(:answer_comment, commentable: object )}
    end
  end

  def do_request(options = {})
    get "api/v1/questions/#{question.id}/answers/#{object.id}", { format: :json }.merge(options)
  end
end