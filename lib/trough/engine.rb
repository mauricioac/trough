module Trough
  class Engine < ::Rails::Engine
    isolate_namespace Trough

    require_relative 'helpers/gem_helper'

    if GemHelper.gem_loaded? :pig
      config.to_prepare do
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
      end

      config.after_initialize do
        ::Pig.setup do |config|
          config.additional_stylesheets << 'trough/application'
          config.additional_javascripts << 'trough/application'
          config.basic_redactor_plugins << 'documentPicker'
          config.redactor_plugins << 'documentPicker'
        end
      end

      config.to_prepare do
        ::Pig::Core::Plugins.register do |plugin|
          plugin.name = "trough_documents"
          plugin.title = "Documents"
          plugin.url = proc { Trough::Engine.routes.url_helpers.documents_path }
          plugin.preferred_position = 2
          plugin.icon = 'file-archive-o'
          plugin.active = Proc.new do |x|
            x.assigns["documents"] && x.assigns["documents"].any?
          end
          plugin.visible = Trough.configuration.permission
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
