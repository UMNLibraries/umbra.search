class PopulateGoogleAnalyticsFacts

  def self.run_monthly!
    results = []
    client  = GoogleAnalyticsClient.connect
    each_day_this_month do |start_date| 
      results.concat GoogleAnalyticsQuery.run!(client, start_date, start_date)
    end
    load(results)
  end

  def self.load(results)
    upsert(results)
  end

  def self.upsert(results)
    rows = []
    results.uniq.each do |result|
      category, action, label, date, count = result
      label = label.split('|')
      if label.length > 1 && record_categories.include?(category)
        record_hash, hostname, path = label
        row = {:category => category, :action => action, :record_hash => extract_hash(record_hash), :hostname => hostname, :path => path, :date => date, :count => count}
        puts label.inspect
        UpsertAnalyticsFact.upsert!(row)
      end
    end
    rows
  end

  # For now, we only ingest stats deling with records as these are used in
  # conjunction with data provider statistics
  def self.record_categories
    ['View Original', 'Record View']
  end

  def self.extract_hash(data)
    data.split("/").last
  end

  def self.each_day_this_month
    (1..days_in_month).each do |day|
      yield get_date(day)
    end
  end

  def self.days_in_month
    Time.new.end_of_month.day
  end

  def self.get_date(day)
    "#{Date.today.strftime("%Y%m")}#{day}"
  end

end