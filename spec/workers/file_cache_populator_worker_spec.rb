require 'spec_helper'

describe FileCachePopulatorWorker do
  it "should use the FileCache to store files" do
    url = "https://www.google.com/images/srpr/logo11w.png"
    expect(FileCache).to receive(:store).with(url)
    subject.perform(url)
  end
end