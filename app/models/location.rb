class Location < ActiveRecord::Base
  has_many :google_analytics_facts
end
