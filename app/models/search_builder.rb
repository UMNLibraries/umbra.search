class SearchBuilder < Blacklight::SearchBuilder
  include Blacklight::Solr::SearchBuilderBehavior
  self.default_processor_chain += [:hide_flagged_records]

  def ability
    @ability ||= Ability.new(self)
  end
  delegate :can?, :cannot?, :to => :ability

  # Hide all records that have been flagged by an enditor
  def hide_flagged_records(solr_parameters)
    unless see_unpublished?
      solr_parameters[:fq] << '-flags_isim:[* TO *]'
    end
  end

  def see_unpublished?
    [:editor, :admin, :subeditor].map do |role|
      current_user.has_role?(role)
    end.select { |has_role| has_role == true}.empty?
  end

  def current_user
    @current_user ||= (scope.current_user) ? scope.current_user : User.new
  end
end