require 'rails_helper'
require './app/services/populate_keywords_field.rb'

describe PopulateKeywordsField do
  subject { PopulateKeywordsField }

  it "combines keyword-related fields into one field" do
    populator = subject.new(solr_doc: {'subject_ssim' => ['african american', 'florida'], 'editor_tags_ssim' => ['Civil Rights'] })
    expected = ["african american", "florida", "Civil Rights"]
    expect(populator.keywords).to eq expected
  end
end