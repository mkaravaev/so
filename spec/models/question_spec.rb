require 'spec_helper'
  
  describe Question do
    it { should have_many :answers }
    it { should have_many :tags_questions }
    it { should have_many :attachments }
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }
    it { should ensure_length_of(:title).is_at_least(7).is_at_most(180) }
    it { should ensure_length_of(:body).is_at_least(10).is_at_most(2048) }
    it { should accept_nested_attributes_for :attachments }
  end