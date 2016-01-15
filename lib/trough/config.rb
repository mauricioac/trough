module Trough
  class Config
    attr_accessor :permission, :mount_path, :extra_roles

    def initialize(options = {})
      self.permission = options[:permission] || -> { true }
      self.mount_path = options[:mount_path] || 'documents'
      self.extra_roles = options[:extra_roles] || []
    end

  end
end
