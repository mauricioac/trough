class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :trough_documents do |t|
      t.string :url
      t.string :attachment_uid
      t.string :slug

      t.timestamps
    end
  end
end


