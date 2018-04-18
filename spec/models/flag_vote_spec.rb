# require 'rails_helper'

# describe FlagVote, type: :model do
#   let(:flag_vote) { build :flag_vote }
#   let(:flag) { create :flag }
#   let(:solr_doc) {
#     random_text = rand(500).to_s
#     doc = SolrDocument.new({
#       id: flag_vote.record_id,
#       title_ssi: random_text,
#       creator_ssim: [random_text],
#       keywords_ssim: [:foo, :bar].sample,
#       dataProvider_ssi: random_text,
#       sourceResource_spatial_state_ssi: random_text,
#       sourceResource_collection_title_ssi: random_text
#       flags_isim: 999
#     }).to_h
#   }

#   before(:each) do
#     reset_solr_with_doc!(solr_doc)
#   end

#   it "adds the correct flag id to a record after being saved" do
#     flag_vote.save
#     expect(flags.include?(flag_vote.flag.id)).to be true
#   end

#   it "removes a flag id after being added and then destroyed" do
#     flag_vote.save
#     flag_vote.destroy
#     expect(flags.include?(flag_vote.flag.id)).to be false
#   end

#   it "allows us to save an old flag vote and its flag ids to its corresponding solr record" do
#     flag_vote.save
#     doc = FlagVote.document(flag_vote.record_id)
#     doc['flags_isim'] = [999]
#     flag_vote.update_record(doc)
#     expect(flags.include?(flag_vote.flag.id)).to be false
#     flag_vote.save
#     expect(flags.include?(flag_vote.flag.id)).to be false
#   end

#   it "updates recods with all flags " do
#     flag_vote.save
#     reset_solr_with_doc!(solr_doc.except('flags_isim'))
#     expect(flags).to eq :missing_flags
#     FlagVote.flag_all!
#     expect(flags).to eq [flag_vote.flag.id]
#   end

#   def flags
#     FlagVote.document(flag_vote.record_id).fetch('flags_isim', :missing_flags)
#   end

#   def reset_solr_with_doc!(doc)
#     Blacklight.default_index.connection.tap do |solr|
#       solr.delete_by_query("*:*", params: { commit: true })
#       solr.add [doc]
#       solr.commit
#     end
#   end
# end
