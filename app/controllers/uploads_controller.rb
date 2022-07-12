require 'zip'

class UploadsController < ApplicationController
  before_action :set_upload, only: %i[ show edit update destroy ]
  before_action :require_login, only: [:new, :edit, :update, :destroy, :index, :show, :create]
  before_action :set_tagging,  only: %i[ edit update ]

  # GET /uploads or /uploads.json
  def index
    @uploads = Upload.all
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
    end
    respond_to do |format|
      format.html { redirect_to uploads_url }
    end
  end

  # PATCH/PUT /uploads/1 or /uploads/1.json
  def update
    result = modify_uploads_topics(@upload, params[:upload][:topics])

    respond_to do |format|
      if result == "exist" || result == "empty"
        if result == "exist"
          flash[:danger] = flash_message.get_duplicate_upload(params[:upload][:topics])
        end
        if result == "empty"
          flash[:danger] = flash_message::INVALID_TOPIC
        end
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      elsif @upload.update(upload_params.except(:topics))
        flash[:success] = flash_message.get_added_topic(params[:upload][:topics])
        format.html { redirect_to edit_upload_path(@upload) }
        # format.html { redirect_to uploads_url}
        format.json { render :edit, status: :ok, location: @upload }
      else
        flash[:danger] = flash_message::ADD_FAIL
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uploads/1 or /uploads/1.json
  def destroy
    respond_to do |format|
      flash[:danger] = flash_message::UPLOAD_DELETED
      format.html { redirect_to uploads_url }
      format.json { head :no_content }
    end
  end

  private

  def modify_uploads_topics(upload, topic)
    upload.uploadlinks.each do |uploadlink|
      if uploadlink.topic.name == topic
        return "exist"
      end
    end

    if (topic == "") || topic.nil?
      return "empty"
    end

    new_topic = Topic.find_by(name: topic)
    if new_topic.nil?
      new_topic = Topic.create(name: topic)
      Uploadlink.create(upload_id: @upload.id, topic_id: new_topic.id, similarity: 100)
    else
      Uploadlink.create(upload_id: @upload.id, topic_id: new_topic.id, similarity: 100)
    end
  end

  def set_tagging
    @all_topics = Upload.get_all_topics
    @linked_topics = Upload.get_linked_topics(@upload)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_upload
    @upload = Upload.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def upload_params
    params.require(:upload).permit(:file, :topics)
  end

  # Ensures that admin must be logged in to access upload feature
  def require_login
    if current_user.nil?
      flash[:danger] = FlashString::TO_LOGIN
      redirect_to "/sign_in"
    end
  end

  def flash_message
    FlashString::UploadString
  end
end
