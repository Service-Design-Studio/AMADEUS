class UploadCategoryLink < ApplicationRecord
  belongs_to :upload
  belongs_to :category
end
