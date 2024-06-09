# frozen_string_literal: true

require 'minitest/autorun'

require_relative '../lib/fatcow/version'
require_relative '../lib/fatcow/icon'

class IconTest < Minitest::Test
  def setup
    @subject = Fatcow::Icon
    @mock_app = Minitest::Mock.new

    def @mock_app.image_tag(url)
      return "<img src=\"#{url}\" data-mock>"
    end
  end

  def test_that_icons_store_their_name
    icon = @subject.new @mock_app, :bell
    assert_equal icon.name, :bell
  end

  def test_that_icons_have_no_status_by_default
    icon = @subject.new @mock_app, :bell
    assert_nil icon.status
  end

  def test_that_icons_can_store_their_status
    icon = @subject.new @mock_app, :bell, :go
    assert_equal icon.name, :bell
    assert_equal icon.status, :go
  end

  def test_that_icons_generate_simple_icons_correctly
    icon = @subject.new @mock_app, :bell

    assert_equal icon.to_html, "<div class=\"fatcow-icon fatcow-icon--#{icon.name}\"><img src=\"/assets/normal/FatCow_Icons32x32/#{icon.name}.png\" data-mock></div>"
  end
end
