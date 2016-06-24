# Example searches help users understand how to search umbra.
class ExampleSearch
  attr_accessor :title, :q, :fq, :solr, :thumbnail

  def initialize(title: '', q: '*:*', fq: '', thumbnail: '')
    @title      = title
    @q          = q
    @fq         = fq
    @thumbnail  = thumbnail
  end
end