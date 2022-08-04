require 'rails_helper'

RSpec.describe ReportWorker do

  describe '#perform' do
    it { should have_many(:uploadlinks) }
    it { should have_many(:uploads) }
  end

end