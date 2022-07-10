require 'zip'
class UploadsController < ApplicationController
  before_action :set_upload, only: %i[ show edit update destroy ]
  before_action :require_login, only: [:new, :edit, :update, :destroy, :index, :show, :create]

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

  # POST /uploads or /uploads.json
  # def create
  #   @upload = Upload.new(upload_params)

  #   respond_to do |format|
  #     if @upload.save
  #       flash[:success] = "Upload was successfully created."
  #       # format.html { redirect_to upload_url(@upload)}
  #       format.html { redirect_to uploads_url}
  #       format.json { render :show, status: :created, location: @upload }
  #     else
  #       flash[:error] = "Upload failed."
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @upload.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def create
    file = params[:upload][:file]
    if !file.nil?
      Upload.unzip_file(file,params)
    end
    respond_to do |format|
      format.html { redirect_to uploads_url }
    end
  end

  # PATCH/PUT /uploads/1 or /uploads/1.json
  def update
    result = create_or_delete_uploads_topics(@upload, params[:upload][:topics])

    respond_to do |format|
      if result == "exist" || result == "empty"
          if result == "exist"
            flash[:danger] = "Current article already includes #{params[:upload][:topics]}!"
          end
          if result == "empty"
            flash[:danger] = "Invalid topic input!"
          end
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      elsif @upload.update(upload_params.except(:topics))
        flash[:success] = "Topics successfully updated."
        format.html { redirect_to edit_upload_path(@upload)}
        # format.html { redirect_to uploads_url}
        format.json { render :edit, status: :ok, location: @upload }
      else
        flash[:danger] = "Update failed."
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uploads/1 or /uploads/1.json
  def destroy
    @upload.destroy

    respond_to do |format|
      flash[:success] = "Upload was successfully destroyed."
      format.html { redirect_to uploads_url}
      format.json { head :no_content }
    end
  end

  private
  def create_or_delete_uploads_topics(upload, topic)
    upload.uploadlinks.each do |uploadlink|
      if uploadlink.topic.name == topic
        return "exist"
      end
    end

    if ((topic == "") || topic.nil?)
      return "empty"
    end

    new_topic = Topic.find_by(name: topic)
    if new_topic.nil?
      new_topic = Topic.create(name: topic)
      new_uploadlink = Uploadlink.create(upload_id: @upload.id, topic_id: new_topic.id, similarity: 100)
    else
      new_uploadlink = Uploadlink.create(upload_id: @upload.id, topic_id: new_topic.id, similarity: 100)
    end

    # upload.uploadlinks.destroy_all
    # tags = tags.strip.split(',')
    # tags.each do |tag|
    #   post.tags << Tag.find_or_create_by(name: tag)
    # end
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_upload
      @upload = Upload.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def upload_params
      params.require(:upload).permit(:title, :file, :topics)
    end


  # Ensures that admin must be logged in to access upload feature
    def require_login

      if current_user.nil?
        flash[:danger] = "You must be logged in to access this section"
        redirect_to "/sign_in"
      end

      # if session[:user_id] != "admin"
      #   flash[:danger] = "You must be logged in to access this section"
      #   redirect_to "/sign_in"
      # end
    end
    
  
end
