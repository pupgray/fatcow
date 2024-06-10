# frozen_string_literal: true

require 'nokogiri'

module Fatcow
  class Icon
    attr_reader :name, :status, :app, :size

    def initialize(app, name, status = nil, **options)
      @app = app
      @name = name
      @status = status

      @size = options[:size] || :regular
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

    def size=(new_size)
      @size = new_size
      clear_document
    end

    def to_html
      document.to_html.html_safe
    end

    alias :to_s :to_html

    def composite?
      if status
        file_exists = File.file? File.join(__dir__, '../../app/assets/images', asset_path)

        return !file_exists
      end

      false
    end

    def asset_path
      return base_icon_path unless status
      "fatcow/#{subdirectory}/#{name}_#{status}.png" if status
    end

    def base_icon_path
      "fatcow/#{subdirectory}/#{name}.png"
    end

    def bullet_icon_path
      return "fatcow/#{subdirectory}/bullet_#{status}.png" if bullet_exists?
      "fatcow/FatCow_Icons16x16/#{status}.png"
    end

    def bullet_exists?
      bullets = %i[archive attach back bell brush bug bulb_off bulb_on burn camera cd chart code_red code connect database document down dvd edit excel find flash gear lightning link magnify medal office palette php powerpoint table textfield up valid vector word world user blue purple pink red orange yellow green white black add delete go error key wrench toggle_minus toggle_plus feed picture disk star arrow_bottom arrow_down arrow_left_2 arrow_left arrow_right_2 arrow_right arrow_top arrow_up]
      bullets.include? status
    end

    def document
      return @document if @document

      @document ||= Nokogiri::HTML::Builder.new do |doc|
        doc.div(class: container_class) {
          if status && composite?
            doc.parent << Nokogiri::HTML.fragment(@app.image_tag(@app.image_url base_icon_path))
            doc.parent << Nokogiri::HTML.fragment(@app.image_tag(@app.image_url(bullet_icon_path), class: bullet_class))
          else
            doc.parent << Nokogiri::HTML.fragment(@app.image_tag(@app.image_url asset_path))
          end
        }
      end.doc.root
    end

    private

    def clear_document
      @document = nil
    end

    def container_class
      return "fatcow-icon fatcow-icon--#{name}" if size == :regular
      "fatcow-icon fatcow-icon--small fatcow-icon--#{name}"
    end

    def bullet_class
      prealigned_bullets = %i[archive attach back bell brush bug bulb_off bulb_on burn camera cd chart code_red code connect database document down dvd edit excel find flash gear lightning link magnify medal office palette php powerpoint table textfield up valid vector word world user]
      return 'fatcow-icon__bullet fatcow-icon__bullet--pre-aligned' if prealigned_bullets.include? status
      return 'fatcow-icon__bullet' if bullet_exists?
      'fatcow-icon__bullet fatcow-icon__bullet--hack'
    end

    def subdirectory
      return 'FatCow_Icons32x32' if size == :regular
      'FatCow_Icons16x16'
    end
  end
end
