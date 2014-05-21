require 'spec_helper'

describe Tag do
  it { should ensure_length_of(:name).is_at_most(20) }
  it { should validate_presence_of(:name) }
  it { should belong_to :question }
end
