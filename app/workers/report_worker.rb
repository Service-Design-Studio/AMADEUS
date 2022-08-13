class ReportWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    # This method that will be called when the worker is queued.
    def perform(zip_id, upload_id)
        if zip_id != ""
            ZipUpload.unzip_file_async(zip_id)
        elsif upload_id != ""
<<<<<<< HEAD
            Upload.run_nltk_async(upload_id)
=======
            Upload.run_nltk(upload_id)
        else return true
>>>>>>> rspec
        end
    
    end

end