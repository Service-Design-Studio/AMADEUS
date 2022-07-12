class Topic < ApplicationRecord
  has_many :uploadlinks, dependent: :destroy
  has_many :uploads, through: :uploadlinks
  validates :name, presence: true, uniqueness: true
  validates :name, :format => { :with => /\A[a-zA-Z0-9_]+\z/}
end
