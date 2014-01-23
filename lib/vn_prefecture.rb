# coding: utf-8
require "vn_prefecture/base"
require "vn_prefecture/config"
require "vn_prefecture/prefecture"
require "vn_prefecture/version"

module VnPrefecture
  @config = Config.new

  def self.included(model_class)
    model_class.extend Base
  end

  def self.setup
    yield @config
  end

  def self.config
    @config
  end
end
