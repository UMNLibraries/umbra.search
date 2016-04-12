require 'rails_helper'

describe BlacklightHelper, :type => :helper do
  it "should use custom DocumentPresenter" do
    expect(helper.presenter_class).to eq Umbra::DocumentPresenter
  end
end