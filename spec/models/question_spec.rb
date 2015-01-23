require 'spec_helper'
  
  describe Question do

    it { should have_many :answers }
    it { should have_many :tags_questions }
    it { should have_many :attachments }
    it { should have_many :comments }
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }
    it { should ensure_length_of(:title).is_at_least(7).is_at_most(180) }
    it { should ensure_length_of(:body).is_at_least(10).is_at_most(2048) }
    it { should accept_nested_attributes_for :attachments }

    # Reputation
  describe 'reputation' do
    let(:user) { create(:user) }
    subject { build(:question, user: user) }

    it 'should calculate reputation after creating' do
      expect(Reputation).to receive(:calculate).with(subject)
      subject.save!
    end

    it 'should not calculate reputation after update' do
      subject.save!
      expect(Reputation).to_not receive(:calculate)
      subject.update(title: "this is new title")
    end

    it 'should save user reputation' do
      allow(Reputation).to receive(:calculate).and_return(5)
      expect { subject.save! }.to change(user, :reputation).by(5)
    end
  end

  describe 'Subscription #subscribe and #unsubscribe' do

    let(:user) { create(:user) }
    let(:question) { create(:question, user: user) }

    context '#subscribe' do
      it 'creates new Subscribe object' do
        expect { question.subscribe(user) }.to change(question.subscribers, :count).by(1)
      end
    end

    context '#unsubscribe' do
      it 'destroy subscription to question' do
        expect { question.unsubscribe(user) }.to change(user.subscriptions, :count).by(-1)
      end
    end
  end

end