require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) { create :user }

  it "saves and retrieves a users roles" do
    roles = ['admin', 'librarian']
    user.roles = roles
    user.save
    expect(User.find(user.id).roles).to eq roles
  end
end
