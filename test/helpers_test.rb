# frozen_string_literal: true

require_relative "test_helper"

class HelpersTest < ActionView::TestCase
  def setup
    @view = ActionView::Base.new(ActionView::LookupContext.new([]), {}, nil)
    @view.extend Fatcow::Helpers
  end

  test "it can render a basic icon" do
    output = @view.fci(:bell)
    assert_dom_equal %{ <div class="fatcow-icon fatcow-icon--bell"><img src="/assets/fatcow/FatCow_Icons32x32/bell-f9c053488c1c35e7591a4362f44e549d0687d81223f4d35936e8cf8688647e59.png"></div>}, output
  end

  test "it can render an annotated icon" do
    output = @view.fci(:bell, :delete)
    assert_dom_equal %{<div class="fatcow-icon fatcow-icon--bell"><img src="/assets/fatcow/FatCow_Icons32x32/bell_delete-1beeb9ca58d1d34f1ac9ffa0aad58155f18920d0f912b07d77f0594f66c3fc76.png"></div>}, output
  end

  test "it can render an annotated icon who has no prerendered single file" do
    output = @view.fci(:action, :delete)
    expected = <<~HTML.chomp
      <div class="fatcow-icon fatcow-icon--action">
      <img src="/assets/fatcow/FatCow_Icons32x32/action-19c453105fb0d41e6e958ceea8cef1c649f4c091e79146d4920fd1f914761da5.png"><img class="fatcow-icon__bullet" src="/assets/fatcow/FatCow_Icons32x32/bullet_delete-5d74dd24f6e423461de3c294e5b8adb6e43b0b6a9c2150ccb6fc8dbb7177ceb4.png">
      </div>
    HTML
    assert_dom_equal expected, output
  end

  test "it can render an annotated icon with a bullet type that is never prerendered" do
    output = @view.fci(:bell, :arrow_left)
    expected = <<~HTML.chomp
      <div class="fatcow-icon fatcow-icon--bell">
      <img src="/assets/fatcow/FatCow_Icons32x32/bell-f9c053488c1c35e7591a4362f44e549d0687d81223f4d35936e8cf8688647e59.png"><img class="fatcow-icon__bullet" src="/assets/fatcow/FatCow_Icons32x32/bullet_arrow_left-be1b6c6c526cdef7b8b53c79192ff7a36b4a91d9b2f23362e9f6c12e26ca9463.png">
      </div>
    HTML
    assert_dom_equal expected, output
  end

  test "it can render an annotated icon with a bullet type that is prealigned" do
    output = @view.fci(:bell, :lightning)
    expected = <<~HTML.chomp
      <div class="fatcow-icon fatcow-icon--bell">
      <img src="/assets/fatcow/FatCow_Icons32x32/bell-f9c053488c1c35e7591a4362f44e549d0687d81223f4d35936e8cf8688647e59.png"><img class="fatcow-icon__bullet fatcow-icon__bullet--pre-aligned" src="/assets/fatcow/FatCow_Icons32x32/bullet_lightning-63a4359ab668b4ffe99e1bbc8b015eecc9fcbee418ddc521e30d3dca6fb125cc.png">
      </div>
    HTML
    assert_dom_equal expected, output
  end
end