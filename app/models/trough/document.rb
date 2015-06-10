module Trough
  class Document < ActiveRecord::Base
  
    validates :file, presence: true
    validates :slug, uniqueness: true
    # validate :file_not_in_blacklist
  
    # Define a refile attachment
    attachment :file
    before_save :set_slug

    class << self
      def blacklist
        ["ade", "adp", "app", "asp", "bas", "bat", "cer", "chm", "cmd", "com", "cpl", "crt", "csh", "der", "exe", "fxp", "gadget", "hlp", "hta", "inf", "ins", "isp", "its", "js",
         "jse", "ksh", "lnk", "mad", "maf", "mag", "mam", "maq", "mar", "mas", "mat", "mau", "mav", "maw", "mda", "mdb", "mde", "mdt", "mdw", "mdz", "msc", "msh", "msh1", "msh2", "mshxml", "msh1xml", 
         "msh2xml", "msi", "msp", "mst", "ops", "pcd", "pif", "plg", "prf", "prg", "pst", "reg", "scf", "scr", "sct", "shb", "shs", "ps1", "ps1xml", "ps2", "ps2xml", "psc1", "psc2", "tmp", "url",
          "vb", "vbe", "vbs", "vsmacros", "vsw", "ws," "wsc", "wsf", "wsh", "xnk"]
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
    
    def set_slug
      escaped_name = file_filename ? file_filename.downcase.gsub(/[^0-9a-z. ]/, '').squish.gsub(' ', '-') : 'temporary'
      temp_slug = escaped_name.dup
      suffix = 1
      while Document.where(slug: temp_slug).present?
        temp_slug = escaped_name.dup
        # Ensure the suffix comes before the file extension
        temp_slug.insert(escaped_name.rindex('.') || escaped_name.length-1, "-#{suffix}")
        suffix += 1
      end
      write_attribute(:slug, temp_slug)
    end
    
  end
end
