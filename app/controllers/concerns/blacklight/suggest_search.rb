module Blacklight
  class SuggestSearch
    attr_reader :request_params
    
    ##
    # @param [Hash] params
    def initialize(params)
      @request_params = { q: params[:q] }
    end

    ##
    # For now, only use the q parameter to create a
    # Blacklight::Suggest::Response
    # @return [Blacklight::Suggest::Response]
    def suggestions
      suggest(search_suggestions)
    end

    ##
    # Query the suggest handler using RSolr::Client::send_and_receive
    # @return [RSolr::HashWithResponse]
    def suggest_results
      Blacklight.default_index.connection.send_and_receive(suggest_handler_path, params: request_params)['suggest']
    end

    ##
    # @return [String]
    def suggest_handler_path
      CatalogController.blacklight_config.autocomplete_path
    end

    private

    def suggest(suggs)
      suggs.fetch(query, {}).fetch('suggestions', [])
    end

    def search_suggestions
      suggest_results.fetch("search_suggest")
    end

    def query
      request_params.fetch(:q, '')
    end

  end
end