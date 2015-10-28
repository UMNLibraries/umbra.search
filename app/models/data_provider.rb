class DataProvider < ActiveRecord::Base
  has_many :records
  has_many :google_analytics_facts, through: :records
end
