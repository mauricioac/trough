module Trough
  class DocumentUsage < ActiveRecord::Base

    belongs_to :document, foreign_key: 'trough_document_id'
    validates :document, presence: true

    if GemHelper.gem_loaded? :pig
      belongs_to :content_package, class_name: '::Pig::ContentPackage', foreign_key: 'pig_content_package_id'
      validates :content_package, presence: true
      validates :document, uniqueness: { scope: :content_package }
    end

    def activate!
      update_attribute(:active, true)
    end

    def deactivate!
      update_attribute(:active, false)
    end

  end
end
