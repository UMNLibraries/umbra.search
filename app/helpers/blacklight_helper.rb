module BlacklightHelper
  include Blacklight::BlacklightHelperBehavior

  def presenter(document)
    Umbra::DocumentPresenter.new(document, self)
  end
end
