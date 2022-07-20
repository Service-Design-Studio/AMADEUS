require 'rails_helper'

RSpec.describe Uploadlink, type: :model do
  it { should belong_to(:upload) }
  it { should belong_to(:topic) }
end
