# frozen_string_literal: true

require_relative 'icon'

module Fatcow
  module Helpers
    def fci(name, status = nil, **options)
      Fatcow::Icon.new(self, name, status, **options)
    end

    def fatcow_style_tag
      content_tag :style do <<~CSS
          .fatcow-icon {
            display: inline-block;
            position: relative;
            image-rendering: crisp-edges;
            user-select: none;
          }
          
          .fatcow-icon__bullet {
            position: absolute;
            top: 0;
            left: 0;
            transform: translate(25%, 25%);
          }
         
          .fatcow-icon > img:not(.fatcow-icon__bullet--hack) {
            width: 100%;
          }
            
          .fatcow-icon__bullet--pre-aligned {
            transform: none;
          }

          .fatcow-icon--small .fatcow-icon__bullet--hack {
            display: inline-block;
            position: static;
            transform: none;
            margin-left: 4px;
          }

          .fatcow-icon:not(.fatcow-icon--small) .fatcow-icon__bullet--hack {
            transform: none;
            bottom: 0;
            right: 0;
            top: initial;
            left: initial;
          }
        CSS
      end
    end
  end
end
