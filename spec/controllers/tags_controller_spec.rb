require 'spec_helper'

describe TagsController do

  let(:user){ create(:user) }
  let(:tag){ create(:tag) }

  describe "GET#index" do
    let(:tags){ create_list(:tag, 2) }
    before { get :index }
      
    it "puts all tags to @tag variable" do
      expect(assigns(:tags)).to match_array(tags)
    end

    it "renders index page" do
      expect(response).to render_template :index
    end
  end

  describe "POST #create" do
    context "user signed in" do
      before { sign_in user }

      context "unexisting tag" do
        it "saves new tag to database" do
          expect { post :create, tag: attributes_for(:tag) }.to change(Tag, :count).by(1)
        end
      end

      context "alredy existing tag" do
        it "not saves tag in database" do
          tag1 = Tag.create(name: "ubyR")
          expect { post :create, tag: { name: "ubyR" } }.to_not change(Tag, :count)
        end
      end
    end

    context "user not signed in" do
      it "redirects to sign in path" do
        post :create, tag: attributes_for(:tag)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
