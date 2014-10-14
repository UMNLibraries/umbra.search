require 'rails_helper'

describe FileCache, :type => :model do
  let(:sample_url) { 'https://www.google.com/images/srpr/logo11w.png' }
  let(:s3_obj) { FileCache.bucket.objects[sample_url] }
  let(:filecache_objects) { {sample_url=>s3_obj }}
  before do
    allow(FileCache).to receive(:objects).and_return(filecache_objects)
    allow(FileCache).to receive(:s3_url_for).with(s3_obj).and_return("http://s3.aws.com/my_secure_url")
  end
  describe "lookup" do
    describe "when object has been cached in S3" do
      before do
        allow(s3_obj).to receive(:exists?).and_return(true)
      end
      it "should return the public url for that S3 object" do
        result = FileCache.lookup(sample_url)
        expect(result).to eq(FileCache.s3_url_for(s3_obj))
      end
    end
    describe "when object is not in S3" do
      before do
        allow(s3_obj).to receive(:exists?).and_return(false)
      end
      it "should return the original URL and schedule a job to store the image for future use" do
        expect(FileCachePopulatorWorker).to receive(:perform_async).with(sample_url)
        result = FileCache.lookup(sample_url)
        expect(result).to eq(sample_url)
      end
    end

  end
  describe "store" do
    it "should store the content from the given URL at a key corresponding to that URL" do
      temp_file_path = FileCache.temp_file_path_for(sample_url)
      expect(FileCache).to receive(:open).with(temp_file_path, 'wb')
      expect(s3_obj).to receive(:write).with(:file => temp_file_path)
      FileCache.store(sample_url)
    end
  end
end