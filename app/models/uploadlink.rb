class Uploadlink < ApplicationRecord
  belongs_to :upload
  belongs_to :topic
end
