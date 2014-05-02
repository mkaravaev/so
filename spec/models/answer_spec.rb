require 'spec_helper'

describe Answer do
  it { should validate_presence_of :body }
  it { should ensure_length_of(:body).is_at_least(10).is_at_most(2048) }
  # it { should belong_to(:question) }
end
