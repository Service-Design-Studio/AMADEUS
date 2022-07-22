class TopicsController < InheritedResources::Base
  before_action :require_login
  before_action :set_topic, only: %i[ show edit update destroy ]

  # GET /topics or /topics.json
  def index
    @topics = Topic.all.reverse
  end

  # GET /topics/1 or /topics/1.json
  def show
  end

  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics or /topics.json
  def create
    @topic = Topic.new(topic_params)

    respond_to do |format|
      new_name = topic_params[:name]
      reply = Topic.verify(new_name)
      if reply[:status] == "success"
        @topic.save!
        flash[:success] = FlashString::TagString.get_added_tag(topic_params[:name])
        format.html { redirect_to topics_path }
        format.json { render :show, status: :created, location: @topic }
      else
        flash[:danger] = reply[:msg]
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

    # PATCH/PUT /topics/1 or /topics/1.json
    def update
      old_name = @topic.name
      respond_to do |format|
        new_name = topic_params[:name]
        reply = Topic.verify(new_name)
        if reply[:status] == "success"
          @topic.update!(topic_params)
          flash[:success] = FlashString::TagString.get_updated_tag(old_name, new_name)
          format.html { redirect_to topics_path }
          format.json { render :show, status: :ok, location: @topic }
        else
          flash[:danger] = reply[:msg]
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @topic.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /topics/1 or /topics/1.json
    def destroy
      @topic.destroy
      respond_to do |format|
        flash[:danger] = FlashString::TagString.get_deleted_tag(@topic.name)
        format.html { redirect_to topics_path }
        format.json { head :no_content }
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