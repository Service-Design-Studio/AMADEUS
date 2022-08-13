require 'rails_helper'

RSpec.describe ReportWorker do

  describe '#perform' do
    it { expect(subject.perform("","")).to be_truthy}
  end

end