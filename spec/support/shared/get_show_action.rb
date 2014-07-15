shared_examples_for "API GET#show" do
  context "GET#show" do

    let(:access_token) { create(:access_token) }

    before do
      do_request(access_token: access_token.token)
    end

    it "returns 200 status code" do
      expect(response.status).to eq 200
    end

    %w(id body created_at updated_at).each do |attr|
      it "object.contstantize object contains #{attr}" do
        expect(response.body).to be_json_eql(object.send(attr.to_sym).to_json).at_path("#{object.class.to_s.downcase}/#{attr}")
      end
    end
    
    it "includes comments in object.class.to_s" do
      expect(response.body).to have_json_size(1).at_path("#{object.class.to_s.downcase}/comments")
    end

    %w(id body created_at updated_at).each do |attr|
      it "object.class.to_s object contains #{attr}" do
        expect(response.body).to be_json_eql(comment.send(attr.to_sym).to_json).at_path("#{object.class.to_s.downcase}/comments/0/#{attr}")
      end
    end
  end

  # def to_name
  #   self.class.to_s.downcase
  # end
end