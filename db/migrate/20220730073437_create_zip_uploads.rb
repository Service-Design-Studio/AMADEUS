class CreateZipUploads < ActiveRecord::Migration[7.0]
  def change
    create_table :zip_uploads do |t|

      t.timestamps
    end
  end
end
