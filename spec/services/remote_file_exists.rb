require 'rails_helper'
require './app/services/remote_file_exists.rb'

describe RemoteFileExists do
  describe 'when an image exists' do
    it "finds the image" do
      url = 'https://drhdun4na00k6.cloudfront.net/51426f085205a6f2297cbc06e9074055cb99d1ec.png'
      expect(RemoteFileExists.new(url: url).exists?).to be true
    end
  end
  describe 'when an image does not exist' do
    url = 'https://drhdun4na00k6.cloudfront.net/51426f085205a6f2297cbc06e9074055cb99d1ecsss1111111111111111111.png'
    it "finds the image" do
      expect(RemoteFileExists.new(url: url).exists?).to be false
    end
  end
end