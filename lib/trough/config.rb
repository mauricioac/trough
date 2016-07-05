module Trough
  class Config
    attr_accessor :permission, :mount_path, :extra_roles,
      :show_file_extensions

    def initialize(options = {})
      self.permission = options[:permission] || -> { true }
      self.mount_path = options[:mount_path] || 'documents'
      self.extra_roles = options[:extra_roles] || []
      self.show_file_extensions = options[:show_file_extensions] || true
    end

  end
end
