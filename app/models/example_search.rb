# Example searches help users understand how to search umbra.
class ExampleSearch
  attr_accessor :title, :q, :fq, :solr

  def initialize(title: '', q: '*:*', fq: '')
    @title = title
    @q     = q
    @fq    = fq
  end
end