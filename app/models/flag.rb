class Flag < ActiveRecord::Base
  has_many :flag_votes
  validates :on_text, presence: true
  validates :off_text, presence: true
end