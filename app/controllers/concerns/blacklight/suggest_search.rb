module Blacklight
  class SuggestSearch
    attr_reader :request_params, :dictionary_param
    
    ##
    # @param [Hash] params
    def initialize(params)
      @request_params = { q: params[:q] }
      @dictionary_param = dictionary(params)
    end

    ##
    # For now, only use the q parameter to create a
    # Blacklight::Suggest::Response
    # @return [Blacklight::Suggest::Response]
    def suggestions
      Blacklight::Suggest::Response.new suggest_results, request_params,  dictionary_param, suggest_handler_path
    end

    ##
    # Query the suggest handler using RSolr::Client::send_and_receive
    # @return [RSolr::HashWithResponse]
    def suggest_results
      Blacklight.default_index.connection.send_and_receive(suggest_handler_path, params: request_params.merge({'suggest.dictionary' => dictionary_param}))
    end

    ##
    # @return [String]
    def suggest_handler_path
      CatalogController.blacklight_config.autocomplete_path
    end

    private

    def dictionary(params)
      params.fetch('suggest.dictionary', 'search_suggest')
    end
  end
end