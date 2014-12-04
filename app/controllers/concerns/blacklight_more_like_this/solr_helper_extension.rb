# Imitates https://github.com/cbeer/blacklight_mlt/blob/master/lib/blacklight_more_like_this/solr_helper_extension.rb
module BlacklightMoreLikeThis
  module SolrHelperExtension
    extend ActiveSupport::Concern

    included do
      CatalogController.solr_search_params_logic += [:add_solr_mlt_parameters]
    end

    def add_solr_mlt_parameters solr_parameters, user_parameters
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
          'mlt.fl' => 'title_t,subject_t,creator_t',
          'mlt.count' => 20,
          'mlt.mintf' => 1
      }
    end

  end
end
