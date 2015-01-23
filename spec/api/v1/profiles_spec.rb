require 'spec_helper'

describe 'Profiles API' do
  describe 'Resource owner user' do
    let(:do_request) { get 'api/v1/profiles', format: :json }
    it_behaves_like "API Authenticable"

    context 'Anuthorized' do
      it 'returns 401 status code if there is not access token' do
        get '/api/v1/profiles/me', format: :json
        expect(response.status).to eq 401
      end

      it 'returns 401 status code if access token is not valid' do
        get '/api/v1/profiles/me', format: :json, access_token: '1234'
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      

      let!(:users) { create_list(:user, 3) }
      let(:me) { users.first }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }
      let(:reputation) do
        mock_model Reputation, user_id: me
      end

      before do
        get '/api/v1/profiles/me', format: :json, access_token: access_token.token
      end

      it 'returns 200 status code' do
        expect(response.status).to eq 200
      end

      %w(id email).each do |attr|
        it "returns #{attr} id" do
          expect(response.body).to be_json_eql(me.send(attr.to_sym).to_json).at_path(attr)
        end
      end

      %w(password encrypted_password).each do |attr|
        it "does not contains #{attr} id" do
          expect(response.body).to_not have_json_path(attr)
        end
      end

      context 'GET#index' do
        let(:user) { create(:user) }

        before do
          get '/api/v1/profiles', format: :json, access_token: access_token.token
        end

        it 'returns all users' do
          expect(response.body).to have_json_size(3)
        end
      end
    end

    def do_request(options={})
      get 'api/v1/profiles/me', { format: :json }.merge(options)
    end
  end 
end
