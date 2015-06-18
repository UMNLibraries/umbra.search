require 'rails_helper'
require "umbra/featured_boards/snapshot"
require 'sidekiq/testing'

describe "snapshot" do
  Sidekiq::Testing.fake!
  let(:preview_url) { 'https://www.google.com' }
  let(:seconds_in_a_day) { (60*60*24) }

  it "takes, retakes and deletes a snapshot" do
    snapshot = Umbra::FeaturedBoards::Snapshot.new(preview_url, seconds_in_a_day)
    snapshot.take!
    first_snapshot_time = snapshot.last_modified_time
    snapshot.take!
    expect(first_snapshot_time).to be < snapshot.last_modified_time
    snapshot.delete
    expect(File.file?("#{Rails.root}/public/#{snapshot.public_path}")).to be false
  end

  it "identifies when a snapshot is ready to be taken or retaken" do
    snapshot = Umbra::FeaturedBoards::Snapshot.new(preview_url, seconds_in_a_day)
    expect(snapshot.time_to_refresh?).to be true
    snapshot.take!
    expect(snapshot.time_to_refresh?).to be false
    # Expire a file
    snapshot = Umbra::FeaturedBoards::Snapshot.new(preview_url, -10)
    snapshot.take!
    expect(snapshot.time_to_refresh?).to be true
    snapshot.delete
  end

end