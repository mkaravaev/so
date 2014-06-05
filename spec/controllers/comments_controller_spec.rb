require 'spec_helper'

describe CommentsController do
  let(:user) { create(:user) }
  let(:question) { create(:question) }
  let(:comment) { create(:comment, user: user, question: question) }


  describe "POST#Create" do
    context "if user signed in" do
      
      before do
        sign_in user
      end

      it "assigns attributes to comment variable" do
        expect { post :create, comment: attributes_for(:comment), format: :js }.to change(Comment, :count).by(1)
      end
    end
  end

end
