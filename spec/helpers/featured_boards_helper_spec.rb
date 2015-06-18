require 'rails_helper'
require 'sidekiq/testing'

describe FeaturedBoardsHelper, :type => :helper do
  let(:board_url) { 'https://www.google.com' }
  let(:seconds_to_expiration) { (60*60*24) }

  it "should take a snapshot" do
    Sidekiq::Testing.fake!
    snapshot = helper.board_snapshot(board_url, 'foo', seconds_to_expiration)
    expect(File.file?("#{Rails.root}/public/#{snapshot.public_path}")).to be true
    snapshot.delete
  end
end
