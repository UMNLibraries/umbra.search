require 'rails_helper'
require './app/services/flag_vote_report.rb'

describe FlagVoteReport do
  let(:record_fetcher) { double }
  let(:vote) { double }
  let(:response) { [{'response' => {'docs' => [{foo: 'bar'}]}}] }

  it "produces a record and vote report" do
    expect(record_fetcher).to receive(:fetch_record).with(42) { response }
    expect(vote).to receive(:record_id) { 42 }
    report = FlagVoteReport.new(flag_votes: [vote], record_fetcher: record_fetcher)
    expect(report.votes_and_records).to eq([{:foo=>"bar"}])
  end

  it "produces flags by record report" do
    vote2 = double
    expect(vote).to receive(:record_id).exactly(2).times { 42 }
    expect(vote).to receive(:flag_id) { 1 }
    expect(vote2).to receive(:record_id).exactly(3).times { 42 }
    expect(vote2).to receive(:flag_id) { 2 }
    report = FlagVoteReport.new(flag_votes: [vote, vote2])
    expect(report.flags_by_record).to eq({42 => [1, 2]})
  end

  it "produces records by flag report" do
    vote2 = double
    expect(vote).to receive(:record_id) { 42 }
    expect(vote).to receive(:flag_id).exactly(3).times { 1 }
    expect(vote2).to receive(:record_id) { 42 }
    expect(vote2).to receive(:flag_id).exactly(3).times { 2 }
    report = FlagVoteReport.new(flag_votes: [vote, vote2])
    expect(report.records_by_flag).to eq([{"1"=>[42]}, {"2"=>[42]}])
  end


end