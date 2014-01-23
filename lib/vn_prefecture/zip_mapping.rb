# coding: utf-8
require 'yaml'

module VnPrefecture
  # コードと郵便番号のマッピング
  module ZipMapping

    filepath = File.join(File.dirname(__FILE__), '../../data/zip.yml')
    @data = YAML.load_file(filepath)
    @data = Hash[*@data.collect{|code, arr|[code, arr.collect{|zip_from, zip_to|zip_from..zip_to}]}.flatten(1)]

    def self.data
      VnPrefecture.config.zip_mapping_data || @data
    end

    def self.code_for_zip zip
      self.data.select do |code, zip_ranges|
        zip_ranges.find{|range|range.include? zip}
      end.keys.first
    end
  end
end
