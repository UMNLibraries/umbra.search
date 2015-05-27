module Umbra::FeaturedBoards
  class Snapshot
    attr_reader :path, :preview_url, :seconds_to_expiration

    def initialize(preview_url, seconds_to_expiration = 0)
      @seconds_to_expiration  = seconds_to_expiration
      @preview_url            = preview_url
    end

    def take!
      mkdir_if_not_exists!
      snap!
    end

    def public_path
      (File.file?(board_file_path)) ? board_file_path.to_s.gsub('public', '') : nil
    end

    def time_to_refresh?
      !File.file?(board_file_path) || expire_snapshot?
    end

    def delete
      File.delete(board_file_path)
    end

    def last_modified_time
      File.mtime(board_file_path)
    end

    private

    def snap!
      Screenshot.snap(preview_url, {
        :output => board_file_path,
        :top => 0, :left => 3, :width => 200, :height => 150 })
    end

    def expire_snapshot?
      last_modified_time_in_seconds + seconds_to_expiration < current_time_in_seconds
    end

    def current_time_in_seconds
      Time.now.to_i
    end

    def last_modified_time_in_seconds
      last_modified_time.to_i
    end

    def filename
      Digest::SHA1.hexdigest preview_url
    end

    def board_file_path
      "public/board_snapshots/#{filename}.png"
    end

    def mkdir_if_not_exists!
      dirname = File.dirname(board_file_path)
      FileUtils.mkdir_p(dirname) if !File.directory?(dirname)
    end

  end
end