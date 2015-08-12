# desc "Explaining what the task does"
namespace :trough do
  task migrate: :environment do
    old_documents = Trough::Document.where('s3_url IS NULL')
    old_documents.each do |doc|
      puts "Updating document - #{doc.id}"
      doc.file_filename = doc.s3_url
      doc.s3_url = nil
      doc.save
    end
  end
end
