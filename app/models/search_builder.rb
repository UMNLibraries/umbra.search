class SearchBuilder < Blacklight::SearchBuilder
  include Blacklight::Solr::SearchBuilderBehavior

  def hide_flagged solr_parameters
    HideFlags.new.hide_flagged(solr_parameters)
  end

  def add_solr_mlt_parameters solr_parameters
    MoreLikeThis.new.add_solr_mlt_parameters(solr_parameters)
  end

  class MoreLikeThis
    def add_solr_mlt_parameters solr_parameters
      return unless solr_parameters[:id]

      solr_parameters[:mlt] = true

      more_like_this_config.keys.select { |x| x.to_s =~ /mlt/ }.each do |k|
        solr_parameters[k] = more_like_this_config[k]
      end
    end

    def solr_doc_params(*args)
      solr_parameters = super(*args)

      add_solr_mlt_parameters(solr_parameters, {})

      solr_parameters
    end

    def more_like_this_config
      {
          'mlt.fl' => 'title_ssi,subject_ssim,creator_ssim',
          'mlt.count' => 20,
          'mlt.mintf' => 1
      }
    end
  end

  class HideFlags
    def hide_flagged solr_parameters
      if !not_ids.empty? && !current_user_is_editor?
        nots = not_ids.join(' -id:')
        solr_parameters['fq'] << "-id:#{nots}"
      end
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
            records << vote unless vote.flag.search_filter_threshold.blank?
          end
        end
      end
      records
    end

    private

    def current_user_is_editor?
      current_user && current_user.has_role?('flag_editor')
    end
  end


end