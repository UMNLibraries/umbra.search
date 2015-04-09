# A secret token used to encrypt user_id's in the Bookmarks#export callback URL
# functionality, for example in Refworks export of Bookmarks. In Rails 4, Blacklight
# will use the application's secret key base instead.
#

Blacklight.secret_key = Rails.application.secrets.secret_key_base

# Remove bookmark from the navbar
CatalogController.blacklight_config.navbar.partials.delete(:bookmark)
# Remove bookmark from catalog#index
CatalogController.blacklight_config.index.document_actions.delete(:bookmark)
# Remove bookmark from catalog#show
CatalogController.blacklight_config.show.document_actions.delete(:bookmark)

