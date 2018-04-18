module ThumbnailHelper

  def thumbnail_src(document)
    return default_thumb_src unless has_thumbnail?(document)
    cdn_url(Digest::SHA1.hexdigest(document['object_ssi']))
  end

  def default_thumb_src
    "#{ENV['NAILER_CDN_URI']}/default_thumbnail.gif"
  end

  def cdn_thumb(key)
    "#{key}.png"
  end

  def cdn_url(key)
    "#{ENV['NAILER_CDN_URI']}/#{cdn_thumb(key)}"
  end

  def current_path
    Rails.root.to_s.gsub(/releases\/[0-9]*/, 'current')
  end

  def has_thumbnail?(document)
    document.fetch('object_ssi', false)
  end
end