  class FeaturedContent < ActiveRecord::Base
  mount_uploader :preview_image, FeaturedContentUploader
  scope :published, -> { where(published: true)}
  paginates_per 10
end
