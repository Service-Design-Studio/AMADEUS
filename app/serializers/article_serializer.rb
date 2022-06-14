class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :category, :summary, :description, :updated_at

  def updated_at
    object.updated_at.to_date
  end
end
