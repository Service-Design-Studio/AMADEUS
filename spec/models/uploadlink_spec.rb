require 'rails_helper'

RSpec.describe UploadTagLink, type: :model do
  it { should belong_to(:upload) }
  it { should belong_to(:tag) }
end
