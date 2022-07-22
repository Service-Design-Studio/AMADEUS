class CategoriesController < InheritedResources::Base
  before_action :require_login
  before_action :set_category, only: %i[ show edit update destroy ]
  # GET /categories or /categories.json

  def index
    @categories = Category.all.reverse
  end

  # GET /categories/1 or /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      new_name = category_params[:name]
      reply = Category.verify(new_name)
      if reply[:status] == "success"
        @category.save!
        flash[:success] = FlashString::CategoryString.get_added_category(category_params[:name])
        format.html { redirect_to categories_path }
        format.json { render :show, status: :created, location: @category }
      else
        flash[:danger] = reply[:msg]
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    old_name = @category.name
    respond_to do |format|
      new_name = category_params[:name]
      reply = Category.verify(new_name)
      if reply[:status] == "success"
        @category.update!(category_params)
        flash[:success] = FlashString::CategoryString.get_updated_category(old_name, new_name)
        format.html { redirect_to categories_path }
        format.json { render :show, status: :ok, location: @category }
      else
        flash[:danger] = reply[:msg]
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      flash[:danger] = FlashString::TagString.get_deleted_tag(@category.name)
      format.html { redirect_to categories_path }
      format.json { head :no_content }
    end
  end

  private

  def set_category
    @category = Category.friendly.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
