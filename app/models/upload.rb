require 'zip'
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

    def self.unzip_file(file, params)
        Zip::File.open(file) do |zipfile|
            zipfile.each do |entry|
              if entry.file?
                new_upload = Upload.new()
                new_upload.file.attach(io: StringIO.new(entry.get_input_stream.read), filename: entry.name)
                new_upload.title = params[:upload][:title]
                new_upload.save
              end
            end
        end
    end

end
