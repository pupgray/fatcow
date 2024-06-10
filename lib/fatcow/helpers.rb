# frozen_string_literal: true

require_relative 'icon'

module Fatcow
  module Helpers
    def fci(name, status = nil, **options)
      if name.respond_to?(:app=)
        name.app = self
        return name
      else
        Fatcow::Icon.new(self, name, status, **options)
      end
    end
  end
end
