require 'rails_helper'

RSpec.describe UploadCategoryLink, type: :model do
  it { should belong_to(:upload) }
  it { should belong_to(:category) }
end
