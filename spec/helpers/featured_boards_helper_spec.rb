require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.inline!

describe FeaturedBoardsHelper, :type => :helper do
  let(:board_url) { 'https://www.google.com' }
  let(:seconds_to_expiration) { (60*60*24) }

  it "should use take a snapshot" do
    snapshot = helper.board_snapshot(board_url, 'foo', seconds_to_expiration)
    expect(File.file?("#{Rails.root}/public/#{snapshot.public_path}")).to be true
    snapshot.delete
  end
end
