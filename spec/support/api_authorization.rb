shared_examples_for "API Authenticable" do
  context 'unauthorized' do
    it 'returns 401 status if no access_token' do
      do_request
      expect(response.status).to eq 401
    end

    it 'returns 401 status code if access_token invalid' do
      do_request(access_token: '1234')
      expect(response.status).to eq 401
    end
  end
end