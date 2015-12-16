module FeaturedContentsHelper

  def published_featured
    Array.wrap(FeaturedContent.published)
  end

  def has_featured_content?
    published_featured.count > 0
  end

  def published_featured_random
    published_featured.shuffle
  end
end
