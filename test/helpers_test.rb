# frozen_string_literal: true

require_relative "test_helper"

class HelpersTest < ActionView::TestCase
  def setup
    @view = ActionView::Base.new(ActionView::LookupContext.new([]), {}, nil)
    @view.extend Fatcow::Helpers
  end

  test "it can render a basic icon" do
    output = @view.fci(:bell)
    assert_dom_equal %{<div class="fatcow-icon fatcow-icon--bell"><img src="/assets/normal/FatCow_Icons32x32/bell.png"></div>}, output
  end

  test "it can render an annotated icon" do
    output = @view.fci(:bell, :delete)
    assert_dom_equal %{<div class="fatcow-icon fatcow-icon--bell"><img src="/assets/normal/FatCow_Icons32x32/bell_delete.png"></div>}, output
  end

  test "it can render an annotated icon who has no prerendered single file" do
    output = @view.fci(:action, :delete)
    assert_dom_equal %{<div class="fatcow-icon fatcow-icon--action"><img src="/assets/normal/FatCow_Icons32x32/action.png"><img class="fatcow-icon__bullet" src="/assets/normal/FatCow_Icons32x32/bullet_delete.png"></div>}, output
  end

  test "it can render an annotated icon with a bullet type that is never prerendered" do
    output = @view.fci(:bell, :arrow_left)
    assert_dom_equal %{<div class="fatcow-icon fatcow-icon--bell"><img src="/assets/normal/FatCow_Icons32x32/bell.png"><img class="fatcow-icon__bullet" src="/assets/normal/FatCow_Icons32x32/bullet_arrow_left.png"></div>}, output
  end
end