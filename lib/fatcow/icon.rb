# frozen_string_literal: true

require 'nokogiri'

module Fatcow
  class Icon
    attr_reader :name, :status, :app

    def initialize(app, name, status = nil)
      @app = app
      @name = name
      @status = status
    end

    def status=(new_status)
      @status = new_status
      clear_document
    end

    def name=(new_name)
      @name = new_name
      clear_document
    end

    def app=(new_app)
      @app = new_app
      clear_document
    end

    def to_html
      document.to_html.html_safe
    end

    alias :to_s :to_html

    def composite?
      if status
        file_exists = File.file? File.join(Fatcow::ASSET_ROOT, '../', asset_path)

        return !file_exists
      end

      false
    end

    def asset_path
      return base_icon_path unless status
      "/assets/normal/FatCow_Icons32x32/#{name}_#{status}.png" if status
    end

    def base_icon_path
      "/assets/normal/FatCow_Icons32x32/#{name}.png"
    end

    def bullet_icon_path
      "/assets/normal/FatCow_Icons32x32/bullet_#{status}.png"
    end

    def document
      return @document if @document

      @document ||= Nokogiri::HTML::Builder.new do |doc|
        doc.div(class: "fatcow-icon fatcow-icon--#{name}") {
          if status && composite?
            doc.parent << Nokogiri::HTML.fragment(@app.image_tag(base_icon_path))
            doc.parent << Nokogiri::HTML.fragment(@app.image_tag(bullet_icon_path, class: bullet_class))
          else
            doc.parent << Nokogiri::HTML.fragment(@app.image_tag(asset_path))
          end
        }
      end.doc.root
    end

    private

    def clear_document
      @document = nil
    end

    def bullet_class
      prealigned_bullets = %i[archive attach back bell brush bug bulb_off bulb_on burn camera cd chart code_red code connect database document down dvd edit excel find flash gear lightning link magnify medal office palette php powerpoint table textfield up valid vector word world user]
      return 'fatcow-icon__bullet fatcow-icon__bullet--pre-aligned' if prealigned_bullets.include? status
      return 'fatcow-icon__bullet'
    end
  end
end
