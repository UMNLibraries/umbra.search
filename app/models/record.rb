class Record < ActiveRecord::Base
  self.primary_key = "record_hash"
  validates :record_hash, uniqueness: {
    message: "No two records may share the same record_hash."
  }
  scope :with_record_hashes, ->(hashes) { where('record_hash IN (?)', hashes) }
end
