class TagsController < InheritedResources::Base
  before_action :set_tag

  # PATCH/PUT /tags/1 or /tags/1.json
  def update
    respond_to do |format|
      new_name = tag_params[:name]
      reply = Tag.verify(new_name)
      if reply[:status] == "success"
        @tag.update!(tag_params)
        flash[:success] = FlashString::TagString.get_added_tag(tag_params[:name])
        format.html { redirect_back fallback_location: root_path }
        format.json { render :show, status: :ok, location: @tag }
        format.turbo_stream { render_flash }
      else
        flash[:danger] = reply[:msg]
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
        format.turbo_stream { render_flash }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_tag
    @tag = Tag.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def tag_params
    params.require(:tag).permit(:name)
  end
end