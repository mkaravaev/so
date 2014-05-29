require 'spec_helper'

describe Tag do
  it { should ensure_length_of(:name).is_at_most(20) }
  it { should validate_presence_of(:name) }
  it { should have_many :tags_questions }
  it { should have_many :questions }
end
