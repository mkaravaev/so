require 'spec_helper'

describe Answer do
  it { should belong_to(:question) }
  it { should have_many :attachments }
  it { should validate_presence_of :body }
  it { should ensure_length_of(:body).is_at_least(10).is_at_most(2048) }

  it { should accept_nested_attributes_for :attachments }
end
