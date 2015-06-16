module Flag::SolrHideFlagged


  def self.included base
   base.search_params_logic += [:hide_flagged]
  end

  def hide_flagged solr_parameters, user_parameters
    if !not_ids.empty?
      nots = not_ids.join(' -id:')
      solr_parameters['fq'] << "-id:#{nots}"
    end
    solr_parameters
  end

  def not_ids
    records = []
    records_to_hide.each do |record|
      records << record[:record_id]
    end
    records
  end

  def records_to_hide
    records = []
    Flag.all.each do |flag|
      if flag.published == true && !flag.search_filter_threshold.blank?
        records << FlagVote.votes_above_threshold(flag.id, flag.search_filter_threshold).to_a
      end
    end
    records << flag_editor_votes
    records.flatten.uniq

  end

  def flag_editor_votes
    records = []
    User.all.each do |user|
      if user.has_role?('flag_editor')
        user.flag_votes.each do |vote|
          records << vote
        end
      end
    end
    records
  end
end