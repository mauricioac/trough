module Trough
  class Config
    attr_accessor :permission

    def initialize(options = {})
      self.permission = options[:permission] || -> { true }
    end

  end
end
