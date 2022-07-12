class Topic < ApplicationRecord
  has_many :uploadlinks, dependent: :destroy
  has_many :uploads, through: :uploadlinks
  validates :name, presence: true, uniqueness: true, allow_blank: false
end
