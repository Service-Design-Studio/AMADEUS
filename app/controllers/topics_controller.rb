class TopicsController < InheritedResources::Base
  before_action :set_topic

  # PATCH/PUT /topics/1 or /topics/1.json
  def update
    respond_to do |format|
      new_name = topic_params[:name]
      reply = Topic.verify(new_name)
      if reply[:status] == "success"
        @topic.update!(topic_params)
        format.html { redirect_to topics_path }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
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