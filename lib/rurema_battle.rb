# frozen_string_literal: true

require 'artii'
require 'net/http'
require 'uri'

class RuremaBattle
  def self.run(class_name:, version: "3.4")
    new(version: version, class_name: class_name).run
  end

  def initialize(version:, class_name:)
    @version = version
    @class_name = class_name
    @io = $stdout
  end

  def run
    response = Net::HTTP.get_response(url)
    if response.is_a?(Net::HTTPSuccess)
      body = response.body.force_encoding('UTF-8')
      @io << body
      @io << '=' * 500 + "\n"
      count = body.length
      @io << Artii::Base.new(font: 'slant').asciify("#{count}") + "\n"
      @io << "#{count}" + "\n"
    else
      raise "#{response.code} #{response.message}"
    end
  end

  private

  def url
    URI.parse("https://docs.ruby-lang.org/ja/#{@version}/class/#{@class_name}.html")
  end
end
