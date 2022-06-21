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
    Zip::File.open(file) do |zipfile|
      zipfile.each do |entry|
        if entry.file?
          new_upload = Upload.new()
          new_upload.file.attach(io: StringIO.new(entry.get_input_stream.read), filename: entry.name)
          new_upload.save
        end
      end
    end
    respond_to do |format|
      format.html { redirect_to uploads_url }
    end
  end

  # PATCH/PUT /uploads/1 or /uploads/1.json
  def update
    respond_to do |format|
      if @upload.update(upload_params)
        flash[:success] = "Upload was successfully updated."
        # format.html { redirect_to upload_url(@upload)}
        format.html { redirect_to uploads_url}
        format.json { render :show, status: :ok, location: @upload }
      else
        flash[:error] = "Update failed."
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
    # Use callbacks to share common setup or constraints between actions.
    def set_upload
      @upload = Upload.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def upload_params
      params.require(:upload).permit(:title, :file)
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
