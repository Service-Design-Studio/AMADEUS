class UploadlinksController < InheritedResources::Base
  before_action :set_uploadlink

  def update
    respond_to do |format|
      if @topic.update!(params[:name])
        format.html { redirect_to(edit_upload_path(@upload)) }
      end
    end
  end

  # DELETE /tags/1 or /tags/1.json
  def destroy
    tag_name = @uploadlink.topic.name
    @uploadlink.destroy

    respond_to do |format|
      flash[:danger] = FlashString::TagString.get_deleted_tag(tag_name)
      format.html { redirect_to edit_upload_path(@upload) }
      format.json { head :no_content }
    end
  end

  private
  def set_uploadlink
    @uploadlink = Uploadlink.find(params[:id])
    @upload = Upload.find(@uploadlink.upload_id)
    @topic = Topic.find(@uploadlink.topic_id)
    @category = @upload.categories.first
    @filename = Upload.get_cleaned_filename(@upload)

    # get all the uploads that are have the same @topic except the current @upload and sort by the the uploadlink that has highest similarity
    # FIX self.set_upload_tag before uncommenting the sorting verion
    # @other_uploads = @topic.uploads.where.not(id: @upload.id).sort_by { |upload| upload.uploadlinks.where(topic_id: @topic.id).first.similarity }.reverse

    # get all the uploads that are have the same @topic except the current @upload and sort by creation date in descending order
    @other_uploads = @topic.uploads.where.not(id: @upload.id).sort_by { |upload| upload.created_at }.reverse

    @other_uploads_categories = @other_uploads.map { |upload| upload.categories.first }
    # get a hash of category and its uploads
    @other_uploads_categories_hash = Hash[@other_uploads_categories.map { |category| [category, @other_uploads.select { |upload| upload.categories[0] == category }] }]
  end
end