class UploadTagLink < ApplicationRecord
  belongs_to :upload
  belongs_to :tag
end
