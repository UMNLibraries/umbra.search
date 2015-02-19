require 'rails_helper'

describe FileCache, :type => :model do
  let(:sample_url) { 'https://www.google.com/images/srpr/logo11w.png' }
  let(:local_filepath) { FileCache.local_filepath_for(sample_url) }

  describe "store" do
    it "should make a database entry for the cached object" do
      http_response_dbl = double(content_type:"image/jpeg", read:"", status:["200", "OK"])
      expect(File).to receive(:open).with(local_filepath, 'wb')
      expect(FileCache).to receive(:downsize_image).with(local_filepath)
      allow(FileCache).to receive(:open).with(sample_url).and_return(http_response_dbl)
      filecache_record = FileCache.store(sample_url)
      expect(filecache_record).to be_instance_of(FileCache)
      expect(filecache_record).to be_persisted
      expect(filecache_record.filepath).to eq local_filepath
      expect(filecache_record.url).to eq sample_url
      expect(filecache_record.content_type).to eq "image/jpeg"
      expect(filecache_record.valid_content).to eq true

    end
    it "should not store text or html files" do
      http_response_dbl = double(content_type:"text/html", read:"", status:["200", "OK"])
      allow(FileCache).to receive(:open).with(sample_url).and_return(http_response_dbl)
      expect(File).to receive(:open).never
      filecache_record = FileCache.store(sample_url)
      expect(filecache_record).to be_persisted
      expect(filecache_record.valid_content).to eq false
    end
    it "should set items 404 errors to invalid" do
      io_dbl = double(status:["400", "Not found"])
      error = OpenURI::HTTPError.new("404 Not Found", io_dbl)
      allow(FileCache).to receive(:open).with(sample_url).and_raise(error)
      expect(File).to receive(:open).never
      filecache_record = FileCache.store(sample_url)
      expect(filecache_record).to be_persisted
      expect(filecache_record.valid_content).to eq false
      expect(filecache_record.content_type).to eq nil
    end
    it "should set items with bad addresses to invalid" do
      bad_sample_url = "http://trollface-lolcat-bravo.io"
      error = SocketError.new('SocketError: getaddrinfo: Name or service not known')
      allow(FileCache).to receive(:open).with(bad_sample_url).and_raise(error)
      filecache_record = FileCache.store(bad_sample_url)
      expect(filecache_record).to be_persisted
      expect(filecache_record.valid_content).to eq false
      expect(filecache_record.content_type).to eq nil
    end
  end
end