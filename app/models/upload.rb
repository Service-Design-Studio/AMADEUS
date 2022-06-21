class Upload < ApplicationRecord
    has_one_attached :file
    validate :validate_attachment_filetype


    private

    def validate_attachment_filetype
        return unless file.attached?

        unless file.content_type.in?(%w[application/pdf])
            errors.add(:file, 'must be a ZIP!')
        end
    end
end
