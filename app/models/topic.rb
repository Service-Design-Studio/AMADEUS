class Topic < ApplicationRecord
    has_many :uploadlinks, dependent: :destroy
    has_many :uploads, through: :uploadlinks
end
