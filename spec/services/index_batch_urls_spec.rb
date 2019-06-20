require 'rails_helper'
require './app/services/aws_api.rb'

describe IndexBatchUrls do
  it "calculates a set of batches to request from a JSONAPI endpoint" do
    urls = IndexBatchUrls.new(start_url: start_url)
    expect(urls.to_a).to eq(["https://lib-metl-prd-01.oit.umn.edu/api/v2/records?filter[all_with_job_id]=82&page[number]=1&page[size]=50", "https://lib-metl-prd-01.oit.umn.edu/api/v2/records?filter[all_with_job_id]=82&page[number]=2&page[size]=50", "https://lib-metl-prd-01.oit.umn.edu/api/v2/records?filter[all_with_job_id]=82&page[number]=3&page[size]=50", "https://lib-metl-prd-01.oit.umn.edu/api/v2/records?filter[all_with_job_id]=82&page[number]=4&page[size]=50", "https://lib-metl-prd-01.oit.umn.edu/api/v2/records?filter[all_with_job_id]=82&page[number]=5&page[size]=50", "https://lib-metl-prd-01.oit.umn.edu/api/v2/records?filter[all_with_job_id]=82&page[number]=6&page[size]=50"])
  end
end