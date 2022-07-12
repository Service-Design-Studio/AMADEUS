class Topic < ApplicationRecord
  has_many :uploadlinks, dependent: :destroy
  has_many :uploads, through: :uploadlinks
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, :format => { :with => /[a-zA-Z0-9_\s\/]/ }
end
