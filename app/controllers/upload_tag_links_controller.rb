class UploadTagLinksController < InheritedResources::Base
  before_action :set_upload_tag_link

  def update
    respond_to do |format|
      if @tag.update!(params[:name])
        format.html { redirect_to(edit_upload_path(@upload)) }
      end
    end
  end

  # DELETE /tags/1 or /tags/1.json
  def destroy
    tag_name = @upload_tag_link.tag.name
    @upload_tag_link.destroy

    respond_to do |format|
      flash[:danger] = FlashString::TagString.get_deleted_tag(tag_name)
      format.html { redirect_to edit_upload_path(@upload) }
      format.json { head :no_content }
    end
  end

  private
  def set_upload_tag_link
    @upload_tag_link = UploadTagLink.find(params[:id])
    @upload = Upload.find(@upload_tag_link.upload_id)
    @tag = Tag.find(@upload_tag_link.tag_id)

    @category = @upload.categories.first
    @filename = Upload.get_cleaned_filename(@upload)

    @other_uploads = @tag.uploads.where.not(id: @upload.id).sort_by { |upload| upload.created_at }.reverse
    @other_uploads_categories = @other_uploads.map { |upload| upload.categories.first }
    @other_uploads_categories_hash = Hash[@other_uploads_categories.map { |category| [category, @other_uploads.select { |upload| upload.categories[0] == category }] }]
    @other_uploads_categories_hash.each do |category, uploads|
      @other_uploads_categories_hash[category] = uploads.sort_by { |upload| upload.created_at }.reverse
    end
  end
end