require 'spec_helper'

describe TagsQuestion do
  it { should belong_to :question }
  it { should belong_to :tag }
end
