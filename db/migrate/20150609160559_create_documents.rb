class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :trough_documents do |t|
      t.string :url
      t.string :attachment_uid
      t.string :slug
      t.string :file_id
      t.string :file_filename
      t.integer :file_size
      t.string :file_content_type

      t.timestamps
    end
  end
end


