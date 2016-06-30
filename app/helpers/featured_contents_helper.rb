module FeaturedContentsHelper

  def published_news
    Array.wrap(published_featured.news).shuffle
  end

  def published_blog
    Array.wrap(published_featured.blog).shuffle
  end

  def published_featured
    FeaturedContent.published
  end

  def has_featured_content?
    published_featured.count > 0
  end

  def featured_content_css_class(featured_content)
    (featured_content.is_news == true) ? ' news ' : ' blog '
  end

end
