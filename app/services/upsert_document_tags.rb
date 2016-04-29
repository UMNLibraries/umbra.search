class UpsertDocumentTags
  attr_reader :tag_objects, :document_id, :tag_klass, :document_tag_klass

  def initialize(tags: [], document_id: nil, tag_klass: Tag, document_tag_klass: DocumentTag)
    @tag_klass          = tag_klass
    @document_tag_klass = document_tag_klass
    @tag_objects        = upsert_tags(tags)
    @document_id        = document_id
  end

  def replace_tags!
    remove_tags!
    add_tags!
  end

  private

  def remove_tags!
    document_tag_klass.destroy_all(document_id: document_id)
  end

  def add_tags!
    tag_objects.map do |tag|
      document_tag_klass.find_or_create_by(document_id: document_id, tag_id: tag.id)
    end
  end

  def upsert_tags(tags)
    tags.map {|tag| upsert_tag(tag) }
  end

  def upsert_tag(tag)
    tag_klass.find_or_create_by(name: tag)
  end

end