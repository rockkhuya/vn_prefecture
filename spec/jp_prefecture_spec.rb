# coding: utf-8
require 'spec_helper'

describe VnPrefecture do
  describe '.included' do
    subject do
      Class.new(ActiveRecord::Base) do
        include VnPrefecture
      end
    end

    it { should respond_to(:vn_prefecture) }
  end

  describe 'include されていない' do
    subject { Class.new(ActiveRecord::Base) }
    it { should_not respond_to(:vn_prefecture) }
  end

  describe '.setup' do
    before do
      filepath = File.join(File.dirname(__FILE__), 'fixtures/prefecture.yml')
      VnPrefecture.setup do |config|
        config.mapping_data = YAML.load_file filepath
      end
    end

    after do
      VnPrefecture.setup do |config|
        config.mapping_data = nil
      end
    end

    it { VnPrefecture::Mapping.data.count.should eq 48 }
  end
end
