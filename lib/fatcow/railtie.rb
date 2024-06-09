# frozen_string_literal: true

require_relative 'helpers'

module Fatcow
  class Railtie < ::Rails::Railtie
    config.before_initialize do
      config.assets.paths << ASSET_ROOT
    end

    initializer "fatcow.view_helpers" do
      ActiveSupport.on_load(:action_view) do
        include Fatcow::Helpers
      end
    end
  end
end
