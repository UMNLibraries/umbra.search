require 'rails_helper'

describe ThumbnailsController, :type => :controller do

  describe "download" do
    let(:sample_url) { "https://www.google.com/images/srpr/logo11w.png?foo=bar" }
    let(:sample_local_path) { "cache/umbra/samplecachethumb.jpg" }
    before do
      allow(controller).to receive(:render)
    end
    context "when the url has been cached" do
      before do
        allow(FileCache).to receive(:lookup).and_return(sample_local_path)
        allow(File).to receive(:zero?).and_return(false)
      end
      it "should return the cached file" do
        expect(controller).to receive(:send_file).with(sample_local_path) # .and_return{controller.render :nothing => true}
        get :download, url: sample_url
      end
    end
    context "when the cached url is an empty file" do
      before do
        allow(FileCache).to receive(:lookup).and_return(sample_local_path)
        allow(File).to receive(:zero?).and_return(true)
      end
      it "should return the cached file" do
        expect(controller).to receive(:send_file).with(controller.send(:default_thumbnail_path)) # .and_return{controller.render :nothing => true}
        get :download, url: sample_url
      end
    end
    context "when the url has not been cached" do
      before do
        allow(FileCache).to receive(:lookup).and_return(false)
      end
      it "should redirect to the original url" do
        get :download, url: sample_url
        expect(response).to redirect_to(sample_url)
      end
    end
  end
end