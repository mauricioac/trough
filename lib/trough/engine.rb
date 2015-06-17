module Trough
  class Engine < ::Rails::Engine
    isolate_namespace Trough

    config.to_prepare do
      if defined? ::Pig
        ::Pig::ContentAttribute.class_eval do
          class << self
            prepend ::Trough::ExtraPigFieldTypes
          end
        end
        Pig.setup do |config|
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
