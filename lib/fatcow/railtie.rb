# frozen_string_literal: true

require_relative 'helpers'

module Fatcow
  class Railtie < ::Rails::Engine
    isolate_namespace Fatcow

    initializer "fatcow.assets.precompile" do |app|
      app.config.assets.precompile << 'fatcow_manifest.js'
    end

    initializer "fatcow.view_helpers" do
      ActiveSupport.on_load(:action_view) do
        include Fatcow::Helpers
      end

      ActiveSupport.on_load(:active_record) do
        include Fatcow::Model
      end
    end
  end
end
