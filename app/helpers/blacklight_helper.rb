module BlacklightHelper
  include Blacklight::BlacklightHelperBehavior

  def presenter(document)
    presenter_class.new(document, self)
  end

  def presenter_class
    Umbra::DocumentPresenter
  end
end
