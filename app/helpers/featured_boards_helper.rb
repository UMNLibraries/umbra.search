module FeaturedBoardsHelper
  def board_snapshot(preview_url, title, seconds_to_expiration)
    snapshot = Umbra::FeaturedBoards::Snapshot.new(preview_url, seconds_to_expiration)
    BoardSnapshotWorker.perform_async(preview_url, seconds_to_expiration) if snapshot.time_to_refresh?
    snapshot
  end

  def render_board_snapshot(preview_url, board_url, title, seconds_to_expiration)
    snapshot = board_snapshot(preview_url, title, seconds_to_expiration)
    render 'featured_boards/board', :title => title, :url => board_url, :path => snapshot.public_path
  end

  def preview_url(board_url)
    "#{request.protocol}#{request.host}:#{request.port}#{board_preview_path}?url=#{board_url}"
  end
end
