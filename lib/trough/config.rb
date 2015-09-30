module Trough
  class Config
    attr_accessor :permission, :mount_path

    def initialize(options = {})
      self.permission = options[:permission] || -> { true }
      self.mount_path = options[:mount_path] || 'documents'
    end

  end
end
