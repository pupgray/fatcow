# frozen_string_literal: true

require_relative "test_helper"

class ModelTest < ActiveSupport::TestCase
  def setup
    @view = ActionView::Base.new(ActionView::LookupContext.new([]), {}, nil)
    @view.extend Fatcow::Helpers
  end

  test 'basic show icon' do
    user = users(:no_status)
    user.save
    assert_matches_snapshot @view.fci(user.show_icon).to_s
  end

  test 'basic show icon default add state when new record' do
    user = users(:no_status).dup
    assert_matches_snapshot @view.fci(user.show_icon).to_s
  end

  test 'basic show icon default destroyed state when new record' do
    user = users(:no_status)
    user.save
    user.destroy
    assert_matches_snapshot @view.fci(user.show_icon).to_s
  end

  test 'basic form icon' do
    user = users(:no_status)
    user.save
    assert_matches_snapshot @view.fci(user.form_icon).to_s
  end

  test 'custom show icon status' do
    user = users(:name_icon)
    user.save
    assert_matches_snapshot @view.fci(user.show_icon).to_s
  end

  test 'custom form icon status' do
    user = users(:special_icon)
    user.save
    assert_matches_snapshot @view.fci(user.form_icon).to_s
  end

  test 'custom show icon status get priority over defaults' do
    user = users(:name_icon).dup
    assert_matches_snapshot @view.fci(user.show_icon).to_s
  end

  test 'custom form icon status get priority over defaults' do
    user = users(:special_icon).dup
    assert_matches_snapshot @view.fci(user.form_icon).to_s
  end

  test 'show icon can support small sizes' do
    user = users(:name_icon)
    assert_matches_snapshot @view.fci(user.show_icon(size: :small)).to_s
  end

  test 'can support oddball statuses that need css hacks' do
    user = users(:name_icon)
    assert_matches_snapshot @view.fci(user.custom_icon(:warning)).to_s
  end

  test 'can support small sizes with oddball statuses that need css hacks' do
    user = users(:name_icon)
    assert_matches_snapshot @view.fci(user.custom_icon(:warning, size: :small)).to_s
  end
end
