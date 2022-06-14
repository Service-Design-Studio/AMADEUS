class ArticlesController < ApplicationController
  before_action :set_article, only: [:update]

  # GET /admin/articles
  def index
    render json: Article.all
  end

  # PUT /admin/articles/1
  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def article_params
    params.permit(:title, :category, :summary, :description)
  end
end
