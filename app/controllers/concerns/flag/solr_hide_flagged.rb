module Flag::SolrHideFlagged


  def self.included base
   base.search_params_logic += [:hide_flagged]
  end

  def hide_flagged solr_parameters, user_parameters
    return solr_parameters if current_user_is_editor?
    Flag.all.each do |flag|
      if !flag.search_filter_threshold.nil?
        if flag.flag_votes.length >= flag.search_filter_threshold
          solr_parameters['fq'] << "-flags_isim:#{flag.id}"
        end
      end
    end
    solr_parameters
  end

  private

  def current_user_is_editor?
    current_user && current_user.has_role?('flag_editor')
  end

end