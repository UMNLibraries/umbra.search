


module Aurora
  class SolrMetadataDump
    
    def run!(start = nil)
      start ||= 0
      rows = 1000
      total = start * rows
      solr = SolrClient.connect
      response = solr.get 'select', :params => {:q => '*:*', :fl => "*", :start => start, :rows => rows}
      response["response"]["docs"].each do |doc| 
        open('documents.txt', 'a') { |f|
          f.puts doc['metadata_tesi']
        }
      end
      next_start = start + 1
      puts "===#{start}/#{total}==(found: #{response['response']['numFound']})==="
      run!(next_start) if response['response']['numFound'] >= total
    end
  end
end