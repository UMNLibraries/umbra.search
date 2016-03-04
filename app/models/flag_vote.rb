require 'digest/sha1'

class FlagVote < ActiveRecord::Base
  include Blacklight::SearchHelper
  after_commit :add_flag_to_record, on: :update
  after_commit :add_flag_to_record, on: :create
  after_commit :remove_flag_from_record, on: :destroy

  belongs_to :user
  belongs_to :flag
  validates :flag_id, presence: true
  validates :record_id, presence: true
  validates :user, presence: true
  validates :user_id, uniqueness: {scope: [:record_id, :flag_id]}
  scope :votes_above_threshold, ->(flag_id, threshold) { select(:record_id).where(flag_id: flag_id).group(:record_id).having("COUNT(record_id) >= ?", threshold) }
  scope :flag_vote, ->(record_id, user_id, flag_id) { where(record_id: record_id, user_id: user_id, flag_id: flag_id) }
  scope :flagged_by_users, ->(record_id) { where(record_id: record_id) }

  def self.votes_and_records(votes)
    summary = {}
    votes.each do |vote|
      summary[vote[:flag_id]] ||= []
      record = yield vote[:record_id]
      summary[vote[:flag_id]] << format_record(record)  unless record.blank?
    end
    summary
  end

  def self.records(votes)
    records = []
    votes.each do |vote|
      record = yield vote[:record_id]
      records << format_record(record) unless record.blank?
    end
    records
  end

  def css_class
    (!id.nil?) ? 'flagged' : 'unflagged'
  end

  def self.find_or_build(record_id, user_id, flag_id)
    vote = flag_vote(record_id, user_id, flag_id).take
    (!vote.nil?) ? vote : self.new(record_id: record_id, user_id: user_id, flag_id: flag_id)
  end

  def self.document(record_id)
    SolrClient.find_record(record_id)
  end

  def add_flag_to_record
    doc   = FlagVote.document(record_id)
    unless doc.nil?
      doc['flags_isim'] ||= []
      doc['flags_isim'] << flag.id
      update_record(doc)
    end
  end

  def remove_flag_from_record
    doc   = FlagVote.document(record_id)
    doc['flags_isim'] ||= []
    doc['flags_isim'].delete(flag.id)
    update_record(doc)
  end

  def self.flag_all!
    FlagVote.all.map {|vote| vote.add_flag_to_record }
  end

  def update_record(doc)
    # _version_ = 1 means the document must exist in the index to do this update
    # See: http://yonik.com/solr/optimistic-concurrency
    doc['_version_'] = 1
    SolrClient.add [doc]
    SolrClient.commit
  end

  private

  def self.format_record(record)
    (record.respond_to?(:last)) ? record.last : record
  end

end