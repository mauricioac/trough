class CreateTroughDocumentUsages < ActiveRecord::Migration
  def change
    create_table :trough_document_usages do |t|
      t.integer :pig_content_package_id
      t.references :trough_document, index: true
      t.integer :download_count, default: 0
      t.boolean :active, default: true
    end
  end
end
