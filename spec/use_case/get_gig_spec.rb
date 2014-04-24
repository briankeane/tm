require 'spec_helper'

module TM

  describe "GetGig" do
    it "calls bullshit if gig not found" do
      result = TM::GetGig.run(99999)
      expect(result.success?).to eq(false)
      expect(result.error).to eq(:gig_not_found)
    end

    it "gets an gig" do
      gig = TM::Database.db.create_gig({ city: "Dallas" })
      result = TM::GetGig.run(gig.id)
      expect(result.success?).to eq(true)
      expect(result.gig.id).to eq(gig.id)
    end
  end
end
