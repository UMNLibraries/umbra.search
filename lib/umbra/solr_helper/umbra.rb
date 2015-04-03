module Umbra::SolrHelper::Umbra

 def self.included base
   base.solr_search_params_logic += [:show_only_umbra_records]
 end

  # solr_search_params_logic methods take two arguments
  # @param [Hash] solr_parameters a hash of parameters to be sent to Solr (via RSolr)
  # @param [Hash] user_parameters a hash of user-supplied parameters (often via `params`)
  def show_only_umbra_records solr_parameters, user_parameters
    solr_parameters['q.alt'] = 'tags_ssim:umbramvp'
    solr_parameters[:"facet.query"] << "sourceResource_date_begin_ssi:[0 TO #{Time.now.year + 2}]"
    solr_parameters
  end
end