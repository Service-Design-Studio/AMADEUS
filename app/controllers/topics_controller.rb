class TopicsController < InheritedResources::Base
  before_action :set_topic, only: %i[ show edit update destroy ]

  # GET /topics or /topics.json
  def index
    @topics = Topic.all
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
      if (@topic[:name].blank?)
        flash[:danger] = flash_message::INVALID_TOPIC
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      elsif Topic.exists?(name: @topic[:name])
        flash[:danger] = flash_message.get_duplicate_topic(@topic[:name])
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      elsif (@topic[:name].match(/^(\s.*|.*\s)$/))
        flash[:danger] = flash_message.get_space(@topic[:name])
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      
      elsif (@topic[:name].match(/[^a-zA-Z0-9\s\/]/))
        flash[:danger] = flash_message.get_special_characters(@topic[:name])
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      elsif @topic.save 
        flash[:success] = flash_message.get_added_topic(topic_params[:name])
        format.html { redirect_to topics_path }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1 or /topics/1.json
  def update
    old_name = @topic.name
    respond_to do |format|
      # if (@topic[:name].blank?)
      #   flash[:danger] = flash_message::INVALID_TOPIC
      #   format.html { render :edit, status: :unprocessable_entity }
      #   format.json { render json: @topic.errors, status: :unprocessable_entity }

      # elsif (@topic[:name].match(/[^a-zA-Z0-9_ ]/))
      #   flash[:danger] = flash_message.get_special_characters(@topic[:name])
      #   format.html { render :edit, status: :unprocessable_entity }
      #   format.json { render json: @topic.errors, status: :unprocessable_entity }

      # elsif Topic.exists?(name: @topic[:name])
      #   flash.now[:danger] = flash_message.get_duplicate_topic(@topic[:name])
      #   format.html { render :edit, status: :unprocessable_entity }
      #   format.json { render json: @topic.errors, status: :unprocessable_entity }
      # end

      if @topic.update(topic_params) 
        flash[:success] = flash_message.get_updated_tag(old_name, topic_params[:name])
        format.html { redirect_to topics_path }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1 or /topics/1.json
  def destroy
    @topic.destroy

    respond_to do |format|
      flash[:danger] = flash_message.get_deleted_topic(@topic.name)
      format.html { redirect_to topics_path }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_topic
    @topic = Topic.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def topic_params
    params.require(:topic).permit(:name)
  end

  def flash_message
    FlashString::TopicString
  end
end