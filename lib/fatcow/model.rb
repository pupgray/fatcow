# frozen_string_literal: true

module Fatcow
  module Model
    extend ActiveSupport::Concern
    include ActionView::Helpers

    included do
      def icon
        icon_name = self.class.const_get :FATCOW_ICON

        return create_icon if new_record?
        return destroy_icon if destroyed?

        Fatcow::Icon.new(self, icon_name)
      end

      def destroy_icon
        icon_name = self.class.const_get :FATCOW_ICON
        Fatcow::Icon.new(self, icon_name, :burn)
      end

      def create_icon
        icon_name = self.class.const_get :FATCOW_ICON
        Fatcow::Icon.new(self, icon_name, :add)
      end
    end

    class_methods do
      def has_icon (icon_name)
        const_set :FATCOW_ICON, icon_name
      end
    end
  end
end
