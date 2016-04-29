class Tag < ActiveRecord::Base
  has_many :record_tags
end
