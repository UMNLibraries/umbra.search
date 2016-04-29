class RecordPresenter < BasePresenter
  presents :record

  def to_solr
    solr_doc['id']                  = record.record_hash
    solr_doc['import_job_name_ssi'] = record.ingest_name
    # TODO: remove the umbramvp filter. We now use the JSONapi index approach
    # whis allows us to grab content by tag, eliminating the need to do so
    # as a solr filter after the fact
    solr_doc['tags_ssim']           = 'umbramvp'
    solr_doc['editor_tags_ssim']    = normalize tags
    solr_doc['subject_ssim']  = subject_tags
    solr_doc.delete('_version_')
    solr_doc
  end

  private

  def subject_tags
    normalize subjects + tags
  end

  def normalize(terms)
    terms.sort.uniq.map { |term| term.titleize }
  end

  def subjects
    @subjects ||= solr_doc.fetch('subject_ssim', [])
  end

  def tags
    record.tag_list.split(',').map {|tag| tag.strip }
  end

  def solr_doc
    record.solr_doc
  end
end