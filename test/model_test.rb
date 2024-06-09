# frozen_string_literal: true

require_relative "test_helper"

class ModelTest < ActiveSupport::TestCase
  test 'basic show icon' do
    user = users(:no_status)
    user.save
    assert_equal user.show_icon.to_s, "<div class=\"fatcow-icon fatcow-icon--user\"><img src=\"/assets/normal/FatCow_Icons32x32/user.png\"></div>"
  end

  test 'basic show icon default add state when new record' do
    user = users(:no_status).dup
    assert_equal user.show_icon.to_s, "<div class=\"fatcow-icon fatcow-icon--user\"><img src=\"/assets/normal/FatCow_Icons32x32/user_add.png\"></div>"
  end

  test 'basic show icon default destroyed state when new record' do
    user = users(:no_status)
    user.save
    user.destroy
    assert_equal user.show_icon.to_s, <<~HTML.chomp
      <div class="fatcow-icon fatcow-icon--user">
      <img src="/assets/normal/FatCow_Icons32x32/user.png"><img class="fatcow-icon__bullet fatcow-icon__bullet--pre-aligned" src="/assets/normal/FatCow_Icons32x32/bullet_burn.png">
      </div>
    HTML
  end

  test 'basic form icon' do
    user = users(:no_status)
    user.save
    assert_equal user.form_icon.to_s, "<div class=\"fatcow-icon fatcow-icon--user\"><img src=\"/assets/normal/FatCow_Icons32x32/user_edit.png\"></div>"
  end

  test 'custom show icon status' do
    user = users(:name_icon)
    user.save
    assert_equal user.show_icon.to_s, <<~HTML.chomp
      <div class=\"fatcow-icon fatcow-icon--user\">
      <img src=\"/assets/normal/FatCow_Icons32x32/user.png\"><img class=\"fatcow-icon__bullet\" src=\"/assets/normal/FatCow_Icons32x32/bullet_star.png\">
      </div>
    HTML
  end

  test 'custom form icon status' do
    user = users(:special_icon)
    user.save
    assert_equal user.form_icon.to_s, <<~HTML.chomp
      <div class=\"fatcow-icon fatcow-icon--user\">
      <img src=\"/assets/normal/FatCow_Icons32x32/user.png\"><img class=\"fatcow-icon__bullet\" src=\"/assets/normal/FatCow_Icons32x32/bullet_wrench.png\">
      </div>
    HTML
  end

  test 'custom show icon status get priority over defaults' do
    user = users(:name_icon).dup
    assert_equal user.show_icon.to_s, <<~HTML.chomp
      <div class=\"fatcow-icon fatcow-icon--user\">
      <img src=\"/assets/normal/FatCow_Icons32x32/user.png\"><img class=\"fatcow-icon__bullet\" src=\"/assets/normal/FatCow_Icons32x32/bullet_star.png\">
      </div>
    HTML
  end

  test 'custom form icon status get priority over defaults' do
    user = users(:special_icon).dup
    assert_equal user.form_icon.to_s, <<~HTML.chomp
      <div class=\"fatcow-icon fatcow-icon--user\">
      <img src=\"/assets/normal/FatCow_Icons32x32/user.png\"><img class=\"fatcow-icon__bullet\" src=\"/assets/normal/FatCow_Icons32x32/bullet_wrench.png\">
      </div>
    HTML
  end

  test 'show icon can support small sizes' do
    user = users(:name_icon)
    assert_equal user.show_icon(size: :small).to_s, <<~HTML.chomp
      <div class=\"fatcow-icon fatcow-icon--small fatcow-icon--user\">
      <img src=\"/assets/normal/FatCow_Icons16x16/user.png\"><img class=\"fatcow-icon__bullet\" src=\"/assets/normal/FatCow_Icons16x16/bullet_star.png\">
      </div>
    HTML
  end

  test 'can support oddball statuses that need css hacks' do
    user = users(:name_icon)
    assert_equal user.custom_icon(:warning).to_s, <<~HTML.chomp
      <div class=\"fatcow-icon fatcow-icon--user\">
      <img src=\"/assets/normal/FatCow_Icons32x32/user.png\"><img class=\"fatcow-icon__bullet fatcow-icon__bullet--hack\" src=\"/assets/normal/FatCow_Icons16x16/warning.png\">
      </div>
    HTML
  end

  test 'can support small sizes with oddball statuses that need css hacks' do
    user = users(:name_icon)
    assert_equal user.custom_icon(:warning, size: :small).to_s, <<~HTML.chomp
      <div class=\"fatcow-icon fatcow-icon--small fatcow-icon--user\">
      <img src=\"/assets/normal/FatCow_Icons16x16/user.png\"><img class=\"fatcow-icon__bullet fatcow-icon__bullet--hack\" src=\"/assets/normal/FatCow_Icons16x16/warning.png\">
      </div>
    HTML
  end
end
