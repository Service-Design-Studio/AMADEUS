class TopicsController < InheritedResources::Base
  before_action :set_topic, only: %i[ show edit update destroy ]

  # GET /tags or /tags.json
  def index
    @topics = Topic.all
  end

  # GET /tags/1 or /tags/1.json
  def show
  end

  # GET /tags/new
  def new
    @topic = Topic.new
  end

  # GET /tags/1/edit
  def edit
  end

  # POST /tags or /tags.json
  def create
    @topic = Topic.new(tag_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to tag_url(@topic), notice: "topic was successfully created." }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tags/1 or /tags/1.json
  def update
    respond_to do |format|
      if @topic.update(tag_params)
        format.html { redirect_to tag_url(@topic), notice: "topic was successfully updated." }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1 or /tags/1.json
  def destroy
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to tags_url, notice: "topic was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tag_params
      params.require(:topic).permit(:name)
    end
end