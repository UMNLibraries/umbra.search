module FlagVoteConcerns
  extend ActiveSupport::Concern

  def get_votes_and_records(flag_votes)
    FlagVote.votes_and_records(flag_votes) do |record_id|
      fetch(record_id).last
    end
  end

  def get_records(flag_votes)
    FlagVote.records(flag_votes) do |record_id|
      fetch(record_id).last
    end
  end
end