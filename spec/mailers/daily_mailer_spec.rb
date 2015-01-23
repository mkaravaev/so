require "spec_helper"

describe DailyMailer do
  describe "digest" do
    let(:user) { create(:user) }
    let(:mail) { DailyMailer.digest(user) }

    it "renders the headers" do
      mail.subject.should eq("Digest")
      mail.to.should eq(["#{user.email}"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
