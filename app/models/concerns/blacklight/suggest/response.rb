module Blacklight
  module Suggest
    class Response
      attr_reader :response, :request_params, :suggest_path, :dictionary_param

      ##
      # Creates a suggest response
      # @param [RSolr::HashWithResponse] response
      # @param [Hash] request_params
      # @param [String] suggest_path
      def initialize(response, request_params, dictionary_param, suggest_path)
        @response = response
        @request_params = request_params
        @suggest_path = suggest_path
        @dictionary_param = dictionary_param
      end

      ##
      # Trys the suggestor response to return suggestions if they are
      # present
      # @return [Array]
      def suggestions
        response.try(:[], suggest_path).try(:[], dictionary_param).try(:[], request_params[:q]).try(:[], 'suggestions') || []
      end
    end
  end
end