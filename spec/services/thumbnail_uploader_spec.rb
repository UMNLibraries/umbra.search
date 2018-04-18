require 'rails_helper'
require './app/services/thumbnail_uploader.rb'

describe ThumbnailUploader do
  let(:cdn_uri) { 'http://totallyserious.cdn.here.com' }
  let(:bucket_key) { '5dfsdfsdsdff2313997285sdf' }
  let(:api_uri) { 'http://ohai-guys-im-an-api.com' }
  let(:api_key) { '123123123123' }
  let(:thumb_fallback_url) { 'http://example.cdn.com/default_thumb.png' }
  let(:thumb_url) { 'http://example.originals.com/blah.png'  }
  let(:file_exists_klass) { double 'FileExists' }
  let(:file_exists_obj) { double 'FileExistsObj' }
  let(:aws_api_klass) { double 'AwsApi' }
  let(:aws_api_obj) { double 'AwsApiObj' }
  let(:api_url) { "#{api_uri}?url=#{thumb_url}&fallback_url=#{thumb_fallback_url}" }
  let(:cdn_url) { "#{cdn_uri}/#{bucket_key}.png" }
  describe 'when an image is not already uploaded it' do
    it "uploads it" do
      expect(file_exists_klass).to receive(:new).with(url: cdn_url) { file_exists_obj }
      expect(file_exists_obj).to receive(:exists?) { false }
      expect(aws_api_klass).to receive(:new).with(url: api_url, api_key: api_key) { aws_api_obj }
      expect(aws_api_obj).to receive(:upload!)
      upload!
    end
  end
  describe 'when an image is already uploaded it' do
    it "does not upload it" do
      expect(file_exists_klass).to receive(:new).with(url: cdn_url) { file_exists_obj }
      expect(file_exists_obj).to receive(:exists?) { true }
      upload!
    end
  end

  def upload!
    ThumbnailUploader.new(cdn_uri: cdn_uri,
      bucket_key: bucket_key,
      api_uri: api_uri,
      api_key: api_key,
      thumb_fallback_url: thumb_fallback_url,
      thumb_url: thumb_url,
      file_exists_klass: file_exists_klass,
      aws_api_klass: aws_api_klass).upload!
  end
end