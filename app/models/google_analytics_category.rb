class GoogleAnalyticsCategory < ActiveRecord::Base
  has_many :google_analytics_actions
end
