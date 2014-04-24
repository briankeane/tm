require 'spec_helper'

describe 'EditGig'  do
  it "calls bullshit if gig isn't found" do
    result = TM::EditGig.run({ gig_id: 98231, cc_sales: 55.55 })
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:gig_not_found)
  end

  it "edits a gig" do
    gig = TM::Database.db.create_gig({ venue: "Gruene Hall", city: "New Braunfels",
                          market: "Also New Braunfels", cc_sales: 50,
                          cash_sales: 100, deposit: 500, walk: 1000,
                          tips: 0, type: "headliner", cover: 5, paid: 55, tour_id: 5,
                          other_bands: ["Randy Rogers Band", "Wade Bowen"] })
    result = TM::EditGig.run({ gig_id: gig.id, venue: "Blue Light", city: "Lubbock",
                            cc_sales: 100.00, cash_sales: 1000.00 })
    expect(result.success?).to eq(true)
    expect(result.gig.venue).to eq("Blue Light")
    expect(result.gig.city).to eq("Lubbock")
    expect(gig.cc_sales).to eq(100.00)
    expect(gig.cash_sales).to eq(1000.00)
    result = TM::EditGig.run({ gig_id: gig.id, deposit: 0, walk: 250, tips: 100, type: "support",
                            cover: 10, paid: 1150, tour_id: 8, other_bands: "Cody Johnson" })
    expect(result.gig.deposit).to eq(0)
    expect(result.gig.walk).to eq(250)
    expect(result.gig.tips).to eq(100)
    expect(result.gig.type).to eq("support")
    expect(result.gig.cover).to eq(10)
    expect(gig.paid).to eq(1150)
    expect(gig.tour_id).to eq(8)
    expect(gig.other_bands).to eq("Cody Johnson")
  end
end
