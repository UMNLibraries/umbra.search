class IndexAllRecords
  def index!
    Record.find_in_batches(batch_size: 500) do |records|
      records.map {|record| IndexRecord.new(record: record).index! }
    end
  end
end