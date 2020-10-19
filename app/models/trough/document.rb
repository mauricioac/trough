module Trough
  class Document < ActiveRecord::Base

    has_many :document_usages, foreign_key: "trough_document_id", dependent: :destroy

    validates :file, :description, presence: true
    validate :file_content_type_cant_change, on: :update
    validates :slug, :md5, uniqueness: true

    # Define a refile attachment
    attachment :file
    before_validation :set_md5
    before_validation :set_slug, on: :create
    after_save :set_content_disposition,  :set_s3_url

    class << self
      def blacklist
        ["ade", "adp", "app", "asp", "bas", "bat", "cer", "chm", "cmd", "com", "cpl", "crt", "csh", "der", "exe", "fxp", "gadget", "hlp", "hta", "inf", "ins", "isp", "its", "js",
         "jse", "ksh", "lnk", "mad", "maf", "mag", "mam", "maq", "mar", "mas", "mat", "mau", "mav", "maw", "mda", "mdb", "mde", "mdt", "mdw", "mdz", "msc", "msh", "msh1", "msh2", "mshxml", "msh1xml",
         "msh2xml", "msi", "msp", "mst", "ops", "pcd", "pif", "plg", "prf", "prg", "pst", "reg", "scf", "scr", "sct", "shb", "shs", "ps1", "ps1xml", "ps2", "ps2xml", "psc1", "psc2", "tmp", "url",
          "vb", "vbe", "vbs", "vsmacros", "vsw", "ws," "wsc", "wsf", "wsh", "xnk"]
      end

      def include_meta
        select("trough_documents.*,
               (SELECT COUNT(*) FROM trough_document_usages WHERE (trough_document_usages.trough_document_id = trough_documents.id AND trough_document_usages.active = 't')) AS active_document_usage_count,
               (SELECT SUM(trough_document_usages.download_count) FROM trough_document_usages WHERE (trough_document_usages.trough_document_id = trough_documents.id)) AS downloads_count")
      end

      def search(term)
        if term.present?
          where('slug iLIKE :term OR description iLIKE :term OR uploader iLIKE :term', term: "%#{term}%")
        else
          all
        end
      end
    end

    def slug_candidates
      [
        :url,
      ]
    end

    def name_and_sequence
      slug = normalize_friendly_id(url)
      "#{slug}--#{attributes['id']}"
    end

    def file_not_in_blacklist
      if attachment && Document.blacklist.include?(attachment.ext)
        errors.add(:attachment, "This filetype is not allowed")
      end
    end

    # TODO: remove temporary fix_for_extensions required for running from console
    def set_slug(fix_for_extensions=false)
      if Trough.configuration.show_file_extensions
        filename = file_filename
      else
        filename = file_filename.split('.')[0...-1].join('.')
      end
      escaped_name = filename ? filename.downcase.gsub(/[^0-9a-z\-_. ]/, '').squish.gsub(' ', '-') : 'temporary'
      temp_slug = escaped_name.dup
      suffix = 1
      while Document.where(slug: temp_slug).present?
        temp_slug = escaped_name.dup
        # Ensure the suffix comes before the file extension
        temp_slug.insert(escaped_name.rindex('.') || escaped_name.length, "-#{suffix}")
        suffix += 1
      end
      if fix_for_extensions
        update_column(:slug, temp_slug)
      else
        write_attribute(:slug, temp_slug)
      end
    end

    def set_md5
      write_attribute(:md5, Digest::MD5.file(file.download).to_s)
    end

    def to_param
      slug.presence || id
    end

    def set_s3_url
      object = get_s3_object(file.id)
      update_column :s3_url, object.public_url
    end

    def set_content_disposition
      object = get_s3_object(file.id)
      object.copy_from(
        copy_source: [object.bucket.name, object.key].join('/'),
        metadata_directive: 'REPLACE',
        metadata: object.metadata,
        content_type: file_content_type,
        content_disposition: "inline\; filename=\"#{file_filename}\""
      )
    end

    def get_description_or_default
      if description.present?
        description
      else
        file_filename.gsub(/[^a-z]/i, " ")
      end
    end

    def create_usage!(content_package_id)
      document_usage = DocumentUsage.find_or_initialize_by(trough_document_id: self.id, pig_content_package_id: content_package_id)
      document_usage.active = true
      document_usage.save
    end

    def uploaded_on
      created_at.strftime('%B %d, %Y')
    end

    private

    def file_content_type_cant_change
      if file_content_type_before_last_save != file_content_type
        errors.add(:file_content_type, 'must be the same as the existing file')
      end
    end

    def get_s3_object(id)
      client = Aws::S3::Client.new(
      access_key_id: ENV["S3_ACCESS_KEY_ID"],
      secret_access_key: ENV['S3_SECRET_ACCESS_KEY'],
      region: ENV['S3_REGION']
      )
      resource = Aws::S3::Resource.new(client: client)
      bucket = resource.bucket ENV['S3_BUCKET_NAME']
      bucket.object(['store', id].join('/'))
    end

  end
end
