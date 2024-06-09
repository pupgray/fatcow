# frozen_string_literal: true

module Fatcow
  module Model
    extend ActiveSupport::Concern
    include ActionView::Helpers

    DEFAULT_SHOW_STATUSES = {
      add: -> { new_record? },
      burn: -> { destroyed? }
    }

    DEFAULT_FORM_STATUSES = {
      edit: -> { persisted? },
      add: -> { true }
    }

    included do
      def show_icon
        current_state = find_icon_status(:FATCOW_ICON_SHOW_STATUSES)

        return custom_icon(current_state) if current_state
        custom_icon(nil) if current_state.nil?
      end

      def form_icon
        current_state = find_icon_status(:FATCOW_ICON_FORM_STATUSES)

        return custom_icon(current_state) if current_state
        custom_icon(nil) if current_state.nil?
      end

      def find_icon_status(statuses_const_key)
        statuses = self.class.const_get statuses_const_key
        current_status = statuses.find { |status, proc| instance_exec(&proc) }

        return nil if current_status.nil?
        current_status[0]
      end

      def custom_icon(status)
        icon = self.class.const_get :FATCOW_ICON

        icon.app = self if icon.app.nil?
        icon.status = status if icon.status != status

        icon
      end
    end

    class_methods do
      def has_icon (icon_name, **statuses)
        const_set :FATCOW_ICON, Fatcow::Icon.new(nil, icon_name)
        const_set :FATCOW_ICON_SHOW_STATUSES, DEFAULT_SHOW_STATUSES.dup.merge(statuses[:show] || {})
        const_set :FATCOW_ICON_FORM_STATUSES, DEFAULT_FORM_STATUSES.dup.merge(statuses[:form] || {})
      end
    end
  end
end
