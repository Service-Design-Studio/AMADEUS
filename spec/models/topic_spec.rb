require 'rails_helper'

RSpec.describe Tag, type: :model do

  describe 'associations' do
    it { should have_many(:upload_tag_links) }
    it { should have_many(:uploads) }
  end

end
