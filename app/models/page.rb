class Page < ActiveRecord::Base
  include FriendlyId
  friendly_id :link_path, use: [:slugged, :finders]

  def should_generate_new_friendly_id?
    link_path_changed?
  end
end
