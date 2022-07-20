class CreateUploadCategoryLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :upload_category_links do |t|
      t.belongs_to :upload, null: false, foreign_key: true
      t.belongs_to :category, null: false, foreign_key: true
      t.timestamps
    end
  end
end
