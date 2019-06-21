class IndexAllRecords
  attr_reader :indexer_klass
  def initialize(indexer_klass: IndexRecord)
    @indexer_klass = indexer_klass
  end
  def index!
    Record.find_in_batches(batch_size: 500) do |records|
      records.map {|record| indexer_klass.new(record: record).index! }
    end
  end
end