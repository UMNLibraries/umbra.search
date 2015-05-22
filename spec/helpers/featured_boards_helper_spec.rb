require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.inline!

describe FeaturedBoardsHelper, :type => :helper do
    let(:board_url) { 'https://www.pinterest.com/umbrasearch/umbrasearch-yale-beinecke-rare-book-and-manuscript' }
    let(:preview_url) { "http://localhost:3000/#{board_preview_path}?url=#{board_url}" }
    let(:filename) { Digest::SHA1.hexdigest board_url }
    let(:board_file_path) { "#{Rails.root}/tmp/board_snapshots/#{filename}.png" }

  before(:each) do
    mkdir_if_not_exists(board_file_path)
  end

  after(:each) do
    File.delete(board_file_path) if File.file?(board_file_path)
    Rails.cache.delete("board_snapshots/#{filename}")
  end

  it "should use take a snapshot and return its file path" do
    helper.take_snapshot(preview_url, filename, board_file_path)
    expect(File.file?(board_file_path)).to be true
    initial_creation_time = File.mtime(board_file_path)
    # Ensure idempotency if refresh_cache is not passed
    helper.take_snapshot(preview_url, filename, board_file_path)
    expect(File.mtime(board_file_path)).to eq initial_creation_time
    # Ensure image is refreshed when refresh cache is true
    helper.take_snapshot(preview_url, filename, board_file_path, refresh_cache = true)
    expect(File.mtime(board_file_path)).to be > initial_creation_time
  end
end
