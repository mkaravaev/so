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
    let(:user) { create(:user) }
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
  end

end
