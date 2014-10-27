require 'rails_helper'

describe ThumbnailsController, :type => :controller do

  describe "download" do
    let(:sample_url) { "https://www.google.com/images/srpr/logo11w.png?foo=bar" }
    let(:sample_local_path) {FileCache.local_filepath_for(sample_url)  }
    let(:cached_record) { FileCache.create(url:sample_url, filepath:sample_local_path ) }
    before do
      allow(controller).to receive(:render)
    end
    context "when the url has been cached and is valid" do
      before do
        cached_record.valid_content = true
        cached_record.save
      end
      it "should return the cached file" do
        expect(controller).to receive(:send_file).with(sample_local_path, :disposition=> :inline)
        get :download, url: sample_url
      end
    end
    context "when the url has been cached as invalid" do
      before do
        cached_record.valid_content = false
        cached_record.save
      end
      it "should return the default thumbnail file" do
        expect(controller).to receive(:send_file).with(controller.send(:default_thumbnail_path), :disposition=> :inline)
        get :download, url: sample_url
      end
    end
    context "when the url has not been cached" do
      it "should redirect to the original url and schedule a job to cache it for future access" do
        uncached_url = "http://different.url.com/thumbnail"
        expect(FileCachePopulatorWorker).to receive(:perform_async).with(uncached_url)
        get :download, url: uncached_url
        expect(response).to redirect_to(uncached_url)
      end
    end
  end
end