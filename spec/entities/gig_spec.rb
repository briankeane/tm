require 'spec_helper'

module TM
  describe 'Gig' do
    it "calculates total merch" do
      gig1 = Gig.new({ venue: "Gruene Hall", city: "New Braunfels",
                        market: "Also New Braunfels", cc_sales: 50,
                        cash_sales: 100, deposit: 500, walk: 1000,
                        tips: 0, tour_id: 1 })
      expect(gig1.total_merch).to eq(150)
    end

    it "calculates total income" do
      gig1 = Gig.new({ venue: "Gruene Hall", city: "New Braunfels",
                        market: "Also New Braunfels", cc_sales: 50,
                        cash_sales: 100, deposit: 500, walk: 1000,
                        tips: 0, tour_id: 1 })
      expect(gig1.total_income).to eq(1650)
    end

    it "calculates total_towards_deposit" do
      gig1 = Gig.new({ venue: "Gruene Hall", city: "New Braunfels",
                        market: "Also New Braunfels", cc_sales: 50,
                        cash_sales: 100, deposit: 500, walk: 1000,
                        tips: 0, tour_id: 1 })
      expect(gig1.total_towards_deposit).to eq(1100)
    end

    it "calculates merch_per_attendee" do
    gig1 = Gig.new({ venue: "Gruene Hall", city: "New Braunfels",
                        market: "Also New Braunfels", cc_sales: 50,
                        cash_sales: 100, deposit: 500, walk: 1000,
                        tips: 0, paid: 150, tour_id: 1 })
    expect(gig1.merch_per_attendee).to eq(1)
    end

  end
end
