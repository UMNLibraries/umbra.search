require 'rails_helper'

describe BlacklightHelper, :type => :helper do
  it "should use custom DocumentPresenter" do
    helper.presenter_class.should == ::DocumentPresenter
  end
end