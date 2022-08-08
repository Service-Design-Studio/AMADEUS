require 'zip'
require "google/cloud/storage"

class ZipUpload < ApplicationRecord
    has_one_attached :file, service: :local
    validates :file, presence: true
    validates :file, file_content_type: { allow: ['application/pdf', 'application/zip'], message: "ZIP should contain PDFs only!" }
    has_many :uploads

    def self.unzip_file_async(zip_id)
        file = ZipUpload.find(zip_id).file
        file_path = ActiveStorage::Blob.service.path_for(file.key)
        Zip::File.open(file_path) do |zip_file|
            zip_file.each do |entry|
                # extract the entry to a file
                if entry.file? && entry.name.end_with?(".pdf")
                    new_upload = Upload.new
                    content = ExtractPdf.get_pdf_text(entry)
                    new_upload.file.attach(io: StringIO.new(entry.get_input_stream.read), filename: entry.name)
                    new_upload.content = content
                    new_upload.ml_status = "Running"
                    new_upload.save
                    # sidekiq to run nltk on new_upload
                    ReportWorker.perform_async("", new_upload.id)
                end
            end
        end
        ZipUpload.destroy(zip_id)
    end
end
