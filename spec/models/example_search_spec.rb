require 'rails_helper'

RSpec.describe ExampleSearch, type: :model do
  it { should respond_to(:q, :fq, :title, :thumbnail) }
end
