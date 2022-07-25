class UploadCategoryLinksController < InheritedResources::Base
  before_action :set_upload_category_link

  # GET /upload_category_links/1/edit
  def edit
  end

  # PATCH/PUT /upload_category_links/1 or /upload_category_links/1.json
  def update
    respond_to do |format|
      reply = Upload.verify_category(@upload, params[:upload_category_link][:categories])
      if reply[:status] == "success"
        flash[:success] = FlashString::CategoryString.get_added_category(params[:upload_category_link][:categories])
        format.html { render edit_upload_path(@upload) }
        format.json { render :edit, status: :ok, location: @category }
        format.turbo_stream { render_flash }
      else
        flash[:danger] = reply[:msg]
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
        format.turbo_stream { render_flash }
      end
    end
  end

  # DELETE /upload_category_links/1 or /upload_category_links/1.json
  def destroy
    @upload_category_link.destroy

    respond_to do |format|
      flash[:danger] = flash_message::DELETED_TAG
      format.html { redirect_to edit_upload_path(@upload) }
      format.json { head :no_content }
    end
  end

  private
  def set_upload_category_link
    @upload_category_link = UploadCategoryLink.find(params[:id])
    @upload = Upload.find(@upload_category_link.upload_id)
    @category = Category.find(@upload_category_link.category_id)
    @other_categories = Category.where.not(id: @category.id)
  end
  
end
