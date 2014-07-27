require 'spec_helper'

describe Answer do
  it { should belong_to(:question) }
  it { should have_many :attachments }
  it { should have_many :comments }
  it { should validate_presence_of :body }
  it { should ensure_length_of(:body).is_at_least(10).is_at_most(2048) }
  it { should accept_nested_attributes_for :attachments }
  
  # Reputation
  describe 'reputation' do
    let(:user) { create(:user) }
    let(:question) { create(:question) }
    subject { build(:answer, user: user, question: question) }

    it 'should calculate reputation after creating' do
      expect(Reputation).to receive(:calculate).with(subject)
      subject.save!
    end

    it 'should not calculate reputation after update' do
      subject.save!
      expect(Reputation).to_not receive(:calculate)
      subject.update(body: "this is new body for answer")
    end
  end

  #Action mailer
  describe 'send email to question owner when new answer to his questino was created' do
    let(:users) { create_list(:user, 3)}
    let(:user) { users.first }
    let(:user1) { users.last }
    let(:question) { create(:question, user: user) }
    let(:answer) { build(:answer, question: question) }

    it 'should send new answer notification after creating new answer' do
      expect(answer).to receive(:send_new_answer_notification)
      answer.save
    end

    it 'should not send new answer notification after updating answer' do
      answer.save
      expect(answer).to_not receive(:send_new_answer_notification)
      answer.update_attributes(body: 'this is new body for the answer')
    end

    it 'should send new_answer notification to mailer' do
      expect(AnswerMailer).to receive(:new_answer).with(answer)
      answer.save
    end

    it 'should not send new_answer notification to mailer' do
      answer.save
      expect(AnswerMailer).to_not receive(:new_answer).with(answer)
      answer.update_attributes(body: 'this is new body for the answer')
    end

    context 'subscribed users should recieve notification for new answer in question' do

      before do
        subscription = Subscription.create(subscriber_id: user, resource_id: question )
        subscription1 = Subscription.create(subscriber_id: user1, resource_id: question )
      end

      it 'should send email to every subscribed for question user' do
        question.subscribers.each { |user| expect(AnswerMailer).to receive(:subscriber_new_answer.with(user).and_call_original)}
        answer.save
      end
    end
  end

end
