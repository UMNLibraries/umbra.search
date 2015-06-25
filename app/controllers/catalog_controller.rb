# -*- encoding : utf-8 -*-
#
class CatalogController < ApplicationController
  include Blacklight::Catalog
  include BlacklightMoreLikeThis::SolrHelperExtension
  include Flag::SolrHideFlagged

  self.search_params_logic += [:show_only_umbra_records]

  def index
    @flags = Array.wrap(Flag.where(:published => true))
    super
  end

  def about
    render :about
  end

  def contribute
    render :contribute
  end

  def contact
    render :contact
  end


  # Override blacklights limit param for facets.
  # See: def solr_facet_params - blacklight-5.7.2/lib/blacklight/solr_helper.rb
  def facet_list_limit
    (params[:limit]) ? params[:limit] : 20
  end

  configure_blacklight do |config|
    config.index.thumbnail_field = :object_ssi

    ## Default parameters to send to solr for all search-like requests. See also SolrHelper#solr_search_params
    config.default_solr_params = {
      :qt => 'search_hub',
      :fl => '*',
      :rows => 50,
      :bq => 'sourceResource_type_ssi:text^50.0'
    }

    config.default_per_page = 50

    # solr path which will be added to solr base url before the other solr params.
    # config.solr_path = 'select'

    # items to show per page, each number in the array represent another option to choose from.
    config.per_page = [10,20,50,100]
    # config.max_per_page = 1000
    ## Default parameters to send on single-document requests to Solr. These settings are the Blackligt defaults (see SolrHelper#solr_doc_params) or
    ## parameters included in the Blacklight-jetty document requestHandler.
    #
    #config.default_document_solr_params = {
    #  :qt => 'document',
    #  ## These are hard-coded in the blacklight 'document' requestHandler
    #  # :fl => '*',
    #  # :rows => 1
    #  # :q => '{!raw f=id v=$id}'
    #}

    # solr field configuration for search results/index views
    config.index.title_field = 'title_ssi'
    config.index.display_type_field = 'sourceResource_type_ssi'
    config.index.thumbnail_method = :cached_thumbnail_tag
    config.show.thumbnail_method = :cached_thumbnail_tag

    config.view.gallery.default = true
    config.view.gallery.partials = [:index]
    config.view.gallery.icon_class = "glyphicon-th"
    # solr field configuration for document/show views
    #config.show.title_field = 'title_display'
    #config.show.display_type_field = 'format'

    # solr fields that will be treated as facets by the blacklight application
    #   The ordering of the field names is the order of the display
    #
    # Setting a limit will trigger Blacklight's 'more' facet values link.
    # * If left unset, then all facet values returned by solr will be displayed.
    # * If set to an integer, then "f.somefield.facet.limit" will be added to
    # solr request, with actual solr request being +1 your configured limit --
    # you configure the number of items you actually want _displayed_ in a page.
    # * If set to 'true', then no additional parameters will be sent to solr,
    # but any 'sniffed' request limit parameters will be used for paging, with
    # paging at requested limit -1. Can sniff from facet.limit or
    # f.specific_field.facet.limit solr request params. This 'true' config
    # can be used if you set limits in :default_solr_params, or as defaults
    # on the solr side in the request handler itself. Request handler defaults
    # sniffing requires solr requests to be made with "echoParams=all", for
    # app code to actually have it echo'd back to see it.
    #
    # :show may be set to false if you don't want the facet to be drawn in the
    # facet bar

    config.add_facet_field 'subject_ssim', :label => 'Keyword', :limit => 20
    # # Note: This tries to set assumed_boundaries for blacklight_range_limit, but it's not working.  Leaving the value set in case it gets fixed in future releases of blacklight_range_limit
    config.add_facet_field 'sourceResource_date_begin_ssi', :label => 'Year', :range => {:assumed_boundaries => [1100, Time.now.year + 2]}
    config.add_facet_field 'creator_ssim', :label => 'Author', :limit => 20
    config.add_facet_field 'dataProvider_ssi', :label => 'Contributing Institution', :limit => 10
    config.add_facet_field 'sourceResource_spatial_state_ssi', :label => 'State', :limit => 10
    config.add_facet_field 'sourceResource_type_ssi', :label => 'Type', :limit => 4

    # NOTE: Collection is HIDDEN SEARCH RESULTS BY A CSS RULE. We keep it in the config, because we still 
    # want to be able to produce a browse by collection facet page.
    config.add_facet_field 'sourceResource_collection_title_ssi', :label => 'From Collection', :limit => 10
    config.add_facet_field 'import_job_name_ssi', :label => 'Import Job Name', :restricted_to_roles => ['librarian', 'admin']
    config.add_facet_field 'import_job_id_isi', :label => 'Import Job ID', :restricted_to_roles => ['librarian', 'admin']

    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.add_facet_fields_to_solr_request!

    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display
    config.add_index_field 'creator_display_ssi'
    config.add_index_field 'dataProvider_ssi', :label => 'Provided By'

    # solr fields to be displayed in the show (single result) view
    #   The ordering of the field names is the order of the display

    #config.add_show_field 'sourceResource_creator_display', :label => 'Authors'
    #config.add_show_field 'sourceResource_description_txt', :label => 'Description'

    config.add_show_field 'sourceResource_type_ssi', :label => 'Type'
    config.add_show_field 'sourceResource_format_ssi', :label => 'Format'

    config.add_show_field 'sourceResource_contributor_ssi', :label => 'Contributors'
    config.add_show_field 'sourceResource_date_displaydate_ssi', :label => 'Created Date'
    config.add_show_field 'sourceResource_publisher_ssi', :label => 'Publisher'
    config.add_show_field 'language_ssi', :label => 'Language'
    config.add_show_field 'sourceResource_extent_ssi', :label => 'Extent'
    # "fielded" search configuration. Used by pulldown among other places.
    # For supported keys in hash, see rdoc for Blacklight::SearchFields
    #
    # Search fields will inherit the :qt solr request handler from
    # config[:default_solr_parameters], OR can specify a different one
    # with a :qt key/value. Below examples inherit, except for subject
    # that specifies the same :qt as default for our own internal
    # testing purposes.
    #
    # The :key is what will be used to identify this BL search field internally,
    # as well as in URLs -- so changing it after deployment may break bookmarked
    # urls.  A display label will be automatically calculated from the :key,
    # or can be specified manually to be different.

    # This one uses all the defaults set by the solr request handler. Which
    # solr request handler? The one set in config[:default_solr_parameters][:qt],
    # since we aren't specifying it otherwise.

    config.add_search_field 'all_fields', :label => 'All Fields'


    # Now we see how to over-ride Solr request handler defaults, in this
    # case for a BL "search field", which is really a dismax aggregate
    # of Solr search fields.

    config.add_search_field('title') do |field|
      # solr_parameters hash are sent to Solr as ordinary url query params.
      field.solr_parameters = { :'spellcheck.dictionary' => 'default' }

      # :solr_local_parameters will be sent using Solr LocalParams
      # syntax, as eg {! qf=$title_qf }. This is neccesary to use
      # Solr parameter de-referencing like $title_qf.
      # See: http://wiki.apache.org/solr/LocalParams
      field.solr_local_parameters = {
        :qf => '$title_qf',
        :pf => '$title_pf'
      }
    end

    config.add_search_field('Author') do |field|
      field.solr_parameters = { :'spellcheck.dictionary' => 'default' }
      field.solr_local_parameters = {
        :qf => '$creator_qf',
        :pf => '$creator_pf'
      }
    end

    # Specifying a :qt only to show it's possible, and so our internal automated
    # tests can test it. In this case it's the same as
    # config[:default_solr_parameters][:qt], so isn't actually neccesary.
    config.add_search_field('subject') do |field|
      field.solr_parameters = { :'spellcheck.dictionary' => 'default' }
      field.qt = 'search'
      field.solr_local_parameters = {
        :qf => '$subject_qf',
        :pf => '$subject_pf'
      }
    end

    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the SOLR field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case).
    config.add_sort_field 'score desc, sourceResource_date_begin_ssi desc, title_ssort asc', :label => 'relevance'
    config.add_sort_field 'sourceResource_date_begin_ssi asc', :label => 'year'
    config.add_sort_field 'creator_display_ssi asc, title_ssort asc', :label => 'author'
    config.add_sort_field 'title_ssort asc, sourceResource_date_begin_ssi desc', :label => 'title'

    # If there are more than this many search results, no spelling ("did you
    # mean") suggestion is offered.
    config.spell_max = 5
  end

end
