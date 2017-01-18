class FlagVoteReport
  attr_reader :flag_votes, :record_fetcher

  def initialize(flag_votes: [],
                 record_fetcher: :missing_record_fetcher)
    @flag_votes     = flag_votes
    @record_fetcher = record_fetcher
  end

  def votes_and_records
    flag_votes.reduce([]) do |report, vote|
      report << fetch(vote.record_id)
    end
  end

  def records_by_flag
    flag_ids.map do |flag_id| 
      {"#{flag_id}" => record_ids(votes_for_flag(flag_id)) }
    end
  end

  def flags_by_record
    flag_votes.inject({}) do |report, vote|
      report.merge(record_flags(report, vote))
    end
  end

  private

  def record_ids(votes)
    votes.map { |vote| vote.record_id }
  end

  def votes_for_flag(flag_id)
    flag_votes.select { |fv| fv.flag_id == flag_id }
  end

  def flag_ids
    flag_votes.map { |vote| vote.flag_id }.uniq
  end

  def record_flags(report, vote)
    if !report[vote.record_id]
      {vote.record_id => [vote.flag_id]}
    else
      {vote.record_id => report[vote.record_id] << vote.flag_id }
    end
  end

  def fetch(record_id)
    # See Blacklight::SearchHelper for def fetch
    record_fetcher.fetch_record(record_id).first['response']['docs'].first
  rescue => e
    raise e.inspect
    Rails.logger.error "#{e}: #{record_id}"
    {}
  end
end