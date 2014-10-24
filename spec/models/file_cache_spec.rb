require 'rails_helper'

describe FileCache, :type => :model do
  let(:sample_url) { 'https://www.google.com/images/srpr/logo11w.png' }

  describe "lookup" do
    describe "when object has been cached in local file store" do
      before do
        allow(File).to receive(:exist?).and_return(true)
      end
      it "should return the local filepath of the cached file" do
        expect( FileCache.lookup(sample_url) ).to eq(FileCache.local_filepath_for(sample_url))
      end
    end
    describe "when object is not in local file store" do
      before do
        allow(File).to receive(:exist?).and_return(false)
      end
      it "should return the original URL and schedule a job to store the image for future use" do
        expect(FileCachePopulatorWorker).to receive(:perform_async).with(sample_url)
        expect( FileCache.lookup(sample_url) ).to eq(false)
      end
    end

  end
  describe "store" do
    it "should store the content from the given URL at a filepath corresponding to that URL" do
      local_filepath = FileCache.local_filepath_for(sample_url)
      expect(FileCache).to receive(:open).with(local_filepath, 'wb')
      FileCache.store(sample_url)
    end
  end
end