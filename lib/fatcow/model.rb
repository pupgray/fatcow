# frozen_string_literal: true

module Fatcow
  module Model
    extend ActiveSupport::Concern
    include ActionView::Helpers::AssetTagHelper

    DEFAULT_SHOW_STATUSES = {
      add: -> { new_record? },
      burn: -> { destroyed? }
    }

    DEFAULT_FORM_STATUSES = {
      edit: -> { persisted? },
      add: -> { true }
    }

    included do
      def show_icon(**options)
        current_state = find_icon_status(:FATCOW_ICON_SHOW_STATUSES, :DEFAULT_SHOW_STATUSES)

        return custom_icon(current_state, **options) if current_state
        custom_icon(nil, **options) if current_state.nil?
      end

      def form_icon(**options)
        current_state = find_icon_status(:FATCOW_ICON_FORM_STATUSES, :DEFAULT_FORM_STATUSES)

        return custom_icon(current_state, **options) if current_state
        custom_icon(nil, **options) if current_state.nil?
      end

      def find_icon_status(statuses_const_key, fallback_const_key)
        statuses = self.class.const_get statuses_const_key
        fallback = self.class.const_get fallback_const_key

        current_status = statuses.find { |status, proc| instance_exec(&proc) }
        current_status = fallback.find { |status, proc| instance_exec(&proc) } if current_status.nil?

        return nil if current_status.nil?
        current_status[0]
      end

      def custom_icon(status, **options)
        icon = self.class.const_get :FATCOW_ICON

        icon.app = self if icon.app.nil?
        icon.status = status if icon.status != status
        icon.size = options[:size] if options[:size] && icon.size != options[:size]
        icon.size = :regular unless options[:size] && icon.size != :regular

        icon
      end
    end

    class_methods do
      def has_icon (icon_name, **statuses)
        const_set :FATCOW_ICON, Fatcow::Icon.new(nil, icon_name)
        const_set :FATCOW_ICON_SHOW_STATUSES, statuses[:show] || {}
        const_set :FATCOW_ICON_FORM_STATUSES, statuses[:form] || {}
      end
    end
  end
end
