module FeaturedBoardsHelper

  def render_snapshot(url, title, refresh_cache = false)
    snapshot_path = snapshot(url, refresh_cache)
    if snapshot_path.nil?
      render 'featured_boards/board', :title => title, :url => url, :path => false
    else
      render 'featured_boards/board', :title => title, :url => url, :path => snapshot_path
    end
  end

  def snapshot(board_url, refresh_cache = false)
    filename = Digest::SHA1.hexdigest board_url
    board_file_path = "public/board_snapshots/#{filename}.png"
    preview_url     = "#{request.protocol}#{request.host}:#{request.port}#{board_preview_path}?url=#{board_url}"
    take_snapshot(preview_url, filename, board_file_path, refresh_cache)
    (File.file?(board_file_path)) ? board_file_path.to_s.gsub('public', '') : nil
  end

  def take_snapshot(preview_url, filename, board_file_path, refresh_cache = false)
    Rails.cache.delete("board_snapshots/#{filename}") if refresh_cache
    Rails.cache.fetch("board_snapshots/#{filename}", expires_in: 12.hours) do
      mkdir_if_not_exists(board_file_path)
      BoardSnapshotWorker.perform_async(preview_url, board_file_path)
    end
  end

  def mkdir_if_not_exists(path)
    dirname = File.dirname(path)
    unless File.directory?(dirname)
      FileUtils.mkdir_p(dirname)
    end
  end
end
