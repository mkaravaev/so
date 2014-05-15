require 'spec_helper'
  
  describe Question do
    it { should have_many(:answers) }
    it { should have_many(:tags) }
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }
    it { should ensure_length_of(:title).is_at_least(7).is_at_most(180) }
    it { should ensure_length_of(:body).is_at_least(10).is_at_most(2048) }
  end