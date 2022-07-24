class TopicsController < InheritedResources::Base
  before_action :set_topic

  # PATCH/PUT /topics/1 or /topics/1.json
  def update
    respond_to do |format|
      new_name = topic_params[:name]
      reply = Topic.verify(new_name)
      if reply[:status] == "success"
        @topic.update!(topic_params)
        flash[:success] = FlashString::TagString.get_added_tag(topic_params[:name])
        format.html { redirect_back fallback_location: root_path }
        format.json { render :show, status: :ok, location: @topic }
        format.turbo_stream { render_flash }
      else
        flash[:danger] = reply[:msg]
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
        format.turbo_stream { render_flash }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_topic
    @topic = Topic.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def topic_params
    params.require(:topic).permit(:name)
  end
end