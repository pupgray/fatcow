# frozen_string_literal: true

require_relative 'icon'

module Fatcow
  module Helpers
    def fci(name, status = nil)
      Fatcow::Icon.new(self, name, status)
    end

    def fatcow_style_tag
      content_tag :style do <<~CSS
          .fatcow-icon {
              display: inline-block;
              position: relative;
          }
          
          .fatcow-icon__bullet {
            position: absolute;
            top: 0;
            left: 0;
            transform: translate(25%, 25%);
          }
            
          .fatcow-icon__bullet--pre-aligned {
            transform: none;
          }
        CSS
      end
    end
  end
end
