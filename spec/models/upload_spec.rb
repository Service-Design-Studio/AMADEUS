require 'rails_helper'

RSpec.describe Upload, type: :model do


  describe 'associations' do
    it { should have_many(:uploadlinks) }
    it { should have_many(:topics) }
    it { should have_one_attached(:file) }
  end

  #it { should allow_value('test.zip').for(:file)}
end
