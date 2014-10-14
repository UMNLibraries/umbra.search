require 'rails_helper'

describe BlacklightHelper, :type => :helper do
  it "should use custom DocumentPresenter" do
    expect(helper.presenter_class).to eq ::DocumentPresenter
  end
end