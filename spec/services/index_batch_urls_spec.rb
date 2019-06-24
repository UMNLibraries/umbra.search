require 'rails_helper'

describe IndexBatchUrls do

  describe 'when given an invalid url' do
    it 'responds with an error' do
      error = 'Request Failed for lskjdflksdjflskjdflskjdf with error No such file or directory @ rb_sysopen - lskjdflksdjflskjdflskjdf'
      expect { IndexBatchUrls.new(start_url: "lskjdflksdjflskjdflskjdf") }.to raise_error(RuntimeError, error)
    end
  end

  it "calculates a set of batches to request from a JSONAPI endpoint" do
    http_klass = double
    http_klass_obj = double
    start_url = 'https://lib-metl-prd-01.oit.umn.edu/api/v2/records?filter[all_with_tag]=umbra_test'
    pages = [
      "https://lib-metl-prd-01.oit.umn.edu/api/v2/records?filter[all_with_tag]=umbra_test&page[number]=1&page[size]=50",
      "https://lib-metl-prd-01.oit.umn.edu/api/v2/records?filter[all_with_tag]=umbra_test&page[number]=2&page[size]=50",
      "https://lib-metl-prd-01.oit.umn.edu/api/v2/records?filter[all_with_tag]=umbra_test&page[number]=3&page[size]=50"
    ]
    expect(http_klass).to receive(:open).with(start_url, { :read_timeout=>601 }).and_yield(http_klass_obj)
    expect(http_klass_obj).to receive(:read) { {'links' => { 'last' => "#{start_url}&page[number]=3&page[size]=50" }}.to_json }
    urls = IndexBatchUrls.new(start_url: start_url, http_klass: http_klass)
    expect(urls.to_a).to eq(pages)
  end


end
