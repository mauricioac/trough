module Trough
  class GemHelper

    class << self
      def gem_loaded? gem
        Gem.loaded_specs.has_key? gem.to_s
      end
    end

  end
end
