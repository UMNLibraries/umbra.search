require 'rails_helper'
require './app/services/aws_api.rb'

describe AwsApi do
  it "posts a URL " do
    url = 'https://example.com/foo?=blah'
    api_key = '12345678910112'
    post_klass = double('Net::HTTP')
    post_klass_obj = double('PostKlassObj')
    expect(post_klass).to receive(:new).with(URI(url)) { {} }
    post = AwsApi.new(url: url, api_key: api_key, post_klass: post_klass).post!
    expect(post).to eq({"x-api-key" => "12345678910112"})
  end
end