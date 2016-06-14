  class FeaturedContent < ActiveRecord::Base
  mount_uploader :preview_image, FeaturedContentUploader
  scope :published, -> { where(published: true)}
  scope :news,      -> { where(is_news: true)}
  scope :blog,      -> { where(is_news: false)}
  paginates_per 10
end
