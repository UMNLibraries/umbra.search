require 'rest-client'

module Aurora
  class Ingester
    attr_reader :ingest_name, :ingest_hash, :batch_size, :dir_path

    def initialize(params)
      @batch_size  = params.fetch(:batch_size, 100).to_i
      @ingest_name = params.fetch(:ingest_name)
      @ingest_hash = params.fetch(:ingest_hash)
      @dir_path    = params.fetch(:directory_path)
    end

    def run!
      load_from_directory(dir_path)
    end

    def load_from_directory(dir_path)
      records = []
      total_posted = 0
      Dir.foreach(dir_path) do |filename|
        next if invalid_batch?(filename)
        record_hash = record_hash(filename.gsub('\.json', ''))
        records << 
          {
            'record_hash' => record_hash, 
            'ingest_hash' => ingest_hash,
            'ingest_name' => ingest_name,
            'metadata'    => metadata("#{dir_path}/#{filename}").encode("UTF-8")
          }
        if records.length == batch_size
          total_posted = total_posted + batch_size
          Rails.logger.info "Ingesting records for #{record_hash}/#{record_hash}: #{records.length}/#{total_posted}"
          UpsertRecords.call(records)
          records = []
        end
      end
      UpsertRecords.call(records) if records.length > 0
    end

    def invalid_batch?(filename)
      filename == '.' || filename == '..'
    end

    def record_hash(record_filename)
      record_filename[0..-6]
    end

    def metadata(filepath)
      (File.open(filepath, 'r').read).encode("UTF-8")
    end
  end
end