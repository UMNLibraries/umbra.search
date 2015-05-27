class Screenshot
  def  self.snap(url, options = {})
    Screencap::Fetcher.new(url).fetch(options)
  end
end