require 'zip'
require 'pdf-reader'

class Upload < ApplicationRecord
  has_one_attached :file
  validate :validate_attachment_filetype
  has_many :uploadlinks, dependent: :destroy
  has_many :topics, through: :uploadlinks


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
            new_upload.title = get_pdf_title(entry)
            new_upload.save
          end
        end
      end
    end

    def self.get_pdf_title(pdf)
      reader = PDF::Reader.new(StringIO.new(pdf.get_input_stream.read))
      first_page = reader.pages[0].text.split("\n")
      title = first_page[0]
    end


end
