class UploadlinksController < InheritedResources::Base
    before_action :set_uploadlink, only: %i[destroy]

    # DELETE /tags/1 or /tags/1.json
    def destroy
        @uploadlink.destroy
  
      respond_to do |format|
        flash[:danger] = "Topic was successfully removed."
        format.html { redirect_to edit_upload_path(@upload)}
        format.json { head :no_content }
      end
    end

    private
    def set_uploadlink
        @uploadlink = Uploadlink.find(params[:id])
        @upload = Upload.find(@uploadlink.upload_id)
    end
end