require 'rails_helper'
require './app/services/populate_keywords_field.rb'

describe PopulateKeywordsField do
  it "combines keyword-related fields into one field" do
    populator = PopulateKeywordsField.new(solr_doc: {'keywords_ssim' => ['african american', 'florida'], 'editor_tags_ssim' => ['Civil Rights'] })
    expect(populator.keywords).to eq ["african american", "florida", "Civil Rights"]
  end
end