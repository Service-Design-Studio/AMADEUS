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
      Upload.unzip_file(file, params)
      respond_to do |format|
        format.html { redirect_to uploads_url }
      end
    end
  end

  # PATCH/PUT /uploads/1 or /uploads/1.json
  def update
    respond_to do |format|
      if !params[:upload][:topics].nil?
        reply = Upload.verify_tag(@upload, params[:upload][:topics])
        if reply[:status] == "success"
          @upload.update!(upload_params.except(:topics))
          flash[:success] = FlashString::TagString.get_added_tag(params[:upload][:topics])
          format.html { redirect_to edit_upload_path(@upload) }
          format.json { render :edit, status: :ok, location: @upload }
        else
          flash[:danger] = reply[:msg]
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @upload.errors, status: :unprocessable_entity }
        end
      elsif !params[:upload][:categories].nil?
        reply = Upload.verify_category(@upload, params[:upload][:categories])
        if reply[:status] == "success"
          @upload.update!(upload_params.except(:categories))
          flash[:success] = FlashString::CategoryString.get_added_category(params[:upload][:categories])
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
      format.html { redirect_to uploads_url }
      format.json { head :no_content }
    end
  end

  private

  def set_linked_resources
    @all_topics = Upload.get_all_topics
    @all_categories = Upload.get_all_categories
    @linked_topics = Upload.get_linked_topics(@upload)
    @linked_category = Upload.get_linked_category(@upload)
    @redirect_count = 0
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
