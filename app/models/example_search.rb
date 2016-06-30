# Example searches help users understand how to search umbra.
class ExampleSearch
  attr_accessor :title, :q, :fq, :solr, :thumbnail, :tour

  def initialize(title: '', q: '*:*', fq: [], thumbnail: '', tour: '')
    @title      = title
    @q          = q
    @fq         = fq
    @thumbnail  = thumbnail
    @tour       = tour
  end
end