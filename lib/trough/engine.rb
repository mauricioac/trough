module Trough
  class Engine < ::Rails::Engine
    isolate_namespace Trough

    require_relative 'helpers/gem_helper'

    config.to_prepare do
      if GemHelper.gem_loaded? :pig
        require_relative 'pig/hooks'

        ::Pig::ContentAttribute.class_eval do
          class << self
            prepend ::Trough::ExtraPigFieldTypes
          end
        end
        ::Pig::ContentPackage.class_eval do
          include Pig::Hooks

          after_update :update_document_usages
          after_destroy :unlink_document_usages
        end
        ::Pig.setup do |config|
          config.additional_stylesheets << 'trough/application'
          config.additional_javascripts << 'trough/application'
        end
      end
    end

    rake_tasks do
      Dir[File.join(File.dirname(__FILE__),'tasks/*.rake')].each { |f| load f }
    end
  end

  module ExtraPigFieldTypes
    def field_types
      super.merge(document: "Document")
    end
  end
end
