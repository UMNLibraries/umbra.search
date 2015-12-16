class GoogleAnalyticsFact < ActiveRecord::Base
  belongs_to :record
  belongs_to :google_analytics_action
  belongs_to :location
end
