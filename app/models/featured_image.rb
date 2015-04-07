class FeaturedImage < ActiveRecord::Base
  mount_uploader :uploaded_image, FeaturedImageUploader
  validates_presence_of :title
end
