require 'zip'

class UploadsController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_upload, only: %i[ show edit update destroy ]
  before_action :set_linked_resources, only: %i[ edit update ]

  # GET /uploads or /uploads.json
  def index
    @uploads = Upload.all.reverse
  end

  # GET /uploads/1 or /uploads/1.json
  def show
  end

  # GET /uploads/new
  def new
    @upload = Upload.new
  end

  # GET /uploads/1/edit
  def edit
  end

  def create
    file = params[:upload][:file]
    unless file.nil?
      # START of sync
      Upload.unzip_file_sync(file, params)
      # END of sync
      new_zip_reply = Upload.save_zip_before_ML(file, params)
      # START of async with sidekiq
      # ReportWorker.perform_async(new_zip_reply[:zip_id], "")
      # END of async
      respond_to do |format|
        flash[:success] = "Successfully uploaded #{new_zip_reply[:zip_name]}, waiting for unzipping and ML processing..."
        format.html { redirect_to uploads_url }
      end
    end
  end

  # PATCH/PUT /uploads/1 or /uploads/1.json
  def update
    respond_to do |format|
      # Update topics
      if !params[:upload][:topics].nil?
          reply = Upload.verify_tag(@upload, params[:upload][:topics], params[:upload][:entity_type])
        if reply[:status] == "success"
          flash[:success] = reply[:msg]
          format.html { redirect_to edit_upload_path(@upload) }
          format.json { render :edit, status: :ok, location: @upload }
        else
          flash[:danger] = reply[:msg]
          format.html { redirect_to edit_upload_path(@upload), status: :unprocessable_entity }
          format.json { render json: @upload.errors, status: :unprocessable_entity }
        end
      # Update category
      elsif !params[:upload][:categories].nil?
        reply = Upload.verify_category(@upload, params[:upload][:categories])
        if reply[:status] == "success"
          flash[:success] = reply[:msg]
          format.html { redirect_to edit_upload_path(@upload) }
          format.json { render :edit, status: :ok, location: @upload }
        else
          flash[:danger] = reply[:msg]
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @upload.errors, status: :unprocessable_entity }
        end
      # Update summary
      elsif !params[:upload][:summary].nil?
        reply = Upload.verify_summary(@upload, params[:upload][:summary])
        if reply[:status] == "success"
          flash[:success] = FlashString::SummaryString::SUMMARY_UPDATED
          format.html { redirect_to edit_upload_path(@upload) }
          format.json { render :edit, status: :ok, location: @upload }
        else
          flash[:danger] = reply[:msg]
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @upload.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /uploads/1 or /uploads/1.json
  def destroy
    @upload.destroy

    respond_to do |format|
      flash[:danger] = flash_message::UPLOAD_DELETED
      format.html { redirect_to uploads_path }
      format.json { head :no_content }
    end
  end

  private

  def set_linked_resources
    @all_topics = Upload.get_all_topics
    @all_topics_types = ["CONSUMER GOOD", "EVENT", "LOCATION", "ORGANIZATION", "PERSON", "WORK OF ART", "OTHER"]
    @all_categories = Upload.get_all_categories
    @linked_topics = Upload.get_linked_topics(@upload)
    @unlinked_topics = Upload.get_unlinked_topics(@upload)
    @linked_category = Upload.get_linked_category(@upload)
    set_filterted_topics(params[:tag_type])
    set_filter_css
  end

  def set_filterted_topics(from_params)
    if from_params.nil? || from_params == ""
      @tag_type = "all"
      @filtered_topics = Topic.all
    else
      @tag_type = from_params.gsub("_", " ")
      @filtered_topics = Topic.where(entity_type: @tag_type)
    end 
  end

  def set_filter_css()
    @filter_css = {
      "CONSUMER GOOD" => "bg-consumer-good-btn",
      "EVENT" => "bg-event-btn",
      "LOCATION" => "bg-location-btn",
      "ORGANIZATION" => "bg-organization-btn",
      "PERSON" => "bg-person-btn",
      "WORK OF ART" => "bg-work-of-art-btn",
      "OTHER" => "bg-other-btn"}

    if @tag_type == "all"
      return @filter_css
    else
      css_tag_type = @tag_type.gsub(" ", "-").downcase
      @filter_css[@tag_type] = "bg-" + css_tag_type + "-active-btn"
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_upload
    @upload = Upload.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def upload_params
    params.require(:upload).permit(:file, :topics, :categories)
  end

  # Ensures that admin must be logged in to access upload feature
  def flash_message
    FlashString::UploadString
  end
end
