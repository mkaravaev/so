require 'spec_helper'

describe 'Profiles API' do
  describe 'Resource owner user' do
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
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      before do
        get '/api/v1/profiles/me', format: :json, access_token: access_token.token
      end

      it 'returns 200 status code' do
        expect(response).to eq 200
        expect(response.body).to eq 0
      end

      %w(id email).each do |attr|

      it 'returns user id' do
        expect(response.body).to be_json_eql(me.id.to_json).at_path('id')
      end

      it 'returns user email' do
        expect(response.body).to be_json_eql(me.email.to_json).at_path('email')
      end

      it 'does not contains password' do
        expect(response.body).to_not json_path('password')
      end

      it 'does not contains password' do
        expect(response.body).to_not json_path('encrypted_password')
      end
    end
  end
end