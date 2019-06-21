require 'rails_helper'
require './app/services/aws_api.rb'

describe AwsApi do
  it "posts a URL " do
    url = 'https://example.com/foo?=blah'
    api_key = '12345678910112'
    post_klass = double('Net::HTTP::Post')
    http_klass = double('Net::HTTP')
    http_klass_obj = double
    expect(post_klass).to receive(:new).with(URI(url)) { {'x-api-key' => 'foo'} }
    expect(http_klass).to receive(:start).with("example.com", 443, {:use_ssl=>true}).and_yield(http_klass_obj)
    expect(http_klass_obj).to receive(:request).with({"x-api-key"=>"12345678910112"})
    AwsApi.new(url: url, api_key: api_key, http_klass: http_klass, post_klass: post_klass).upload!
  end
end