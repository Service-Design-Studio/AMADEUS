class UploadCategoryLinksController < InheritedResources::Base
  before_action :set_upload_category_link

  # DELETE /tags/1 or /tags/1.json
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
  end
end
