# frozen_string_literal: true

require_relative "test_helper"

class FatcowTest < ActiveSupport::TestCase
  test "it has a version number" do
    assert Fatcow::VERSION
  end

  test "it adds the asset path to the application" do
    assert_includes Dummy::Application.config.assets.paths, File.expand_path("../lib/fatcow/assets", __dir__)
  end

  test "it registers the fci helper" do
    ActiveSupport.run_load_hooks(:action_view, ActionView::Base)
    assert_includes ActionView::Base.instance_methods, :fci
  end
end
