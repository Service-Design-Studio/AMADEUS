class CreateUploadlinks < ActiveRecord::Migration[7.0]
  def change
    create_table :uploadlinks do |t|
      t.belongs_to :upload, null: false, foreign_key: true
      t.belongs_to :topic, null: false, foreign_key: true
      t.integer :similarity, default: 0
      t.timestamps
    end
  end
end
