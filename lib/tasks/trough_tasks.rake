# desc "Explaining what the task does"
namespace :trough do
  task migrate: :environment do
    old_documents = Trough::Document.where('url IS NOT NULl')
    old_documents.each do |doc|
      puts "Updating document - #{doc.id}"
      doc.file_filename = doc.url
      doc.url = nil
      doc.save
    end
  end
end