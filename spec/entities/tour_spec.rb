require 'spec_helper'

module TM
  describe 'Tour' do

    before do
      @artist = TM::Database.db.create_artist({ name: "Brian Keane", manager_share: 0,
                                      booking_share: 0.10 })
      @tour = TM::Database.db.create_tour({ start_date: Date.new(2014, 1, 29), end_date: Date.new(2014, 1, 31), artist_id: @artist.id })
      @gig1 = TM::Database.db.create_gig({ venue: "Fort Worth Stock Show and Rodeo",
                                    city: "Fort Worth",
                                    market: "DFW",
                                    cc_sales: 0.0,
                                    cash_sales: 35.00,
                                    deposit: 0.0,
                                    walk: 1750.00,
                                    tips: 0.0,
                                    type: "Headliner",
                                    cover: 0,
                                    paid: 300,
                                    tour_id: @tour.id })
      @gig2 = TM::Database.db.create_gig({ venue: "The Tap",
                                            city: "College Station",
                                            market: "College Station",
                                            cc_sales: 40.0,
                                            cash_sales: 35.00,
                                            deposit: 0.0,
                                            walk: 500.0,
                                            tips: 0.0,
                                            type: "Headliner",
                                            cover: 7.00,
                                            paid: 45,
                                            tour_id: @tour.id })
      @gig3 = TM::Database.db.create_gig({ venue: "Chicken Ranch Dancehall",
                                            city: "Ledbetter",
                                            market: "Ledbetter",
                                            cc_sales: 0.0,
                                            cash_sales: 5.0,
                                            deposit: 0.0,
                                            walk: 300.00,
                                            tips: 0.0,
                                            type: "Support",
                                            cover: 15,
                                            paid: 650,
                                            tour_id: @tour.id })
      @expense1 = TM::Database.db.create_transaction({ amount: -20.00,
                                                        source: "cash",
                                                        description: "Bar Tip",
                                                        date: Date.new(2014, 1, 30),
                                                        tour_id: @tour.id
                                                         })
      @expense2 = TM::Database.db.create_transaction({ amount: -200.00,
                                                        source: "cash",
                                                        description: "Employee Pay",
                                                        date: Date.new(2014, 1, 31),
                                                        tour_id: @tour.id
                                                         })
      @expense3 = TM::Database.db.create_transaction({ amount: -250.00,
                                                        source: "cash",
                                                        description: "Employee Pay",
                                                        date: Date.new(2014, 1, 31),
                                                        tour_id: @tour.id
                                                         })
      @expense4 = TM::Database.db.create_transaction({ amount: -55.00,
                                                        source: "cc",
                                                        description: "Gas",
                                                        date: Date.new(2014, 1, 31),
                                                        tour_id: @tour.id
                                                         })
      @expense5 = TM::Database.db.create_transaction({ amount: -87.00,
                                                        source: "cc",
                                                        description: "Gas",
                                                        date: Date.new(2014, 1, 31),
                                                        tour_id: @tour.id
                                                         })
      @expense6 = TM::Database.db.create_transaction({ amount: -40.00,
                                                        source: "cc",
                                                        description: "Gas",
                                                        date: Date.new(2014, 1, 31),
                                                        tour_id: @tour.id
                                                         })
      @expense7 = TM::Database.db.create_transaction({ amount: -70.00,
                                                        source: "cc",
                                                        description: "Gas",
                                                        date: Date.new(2014, 1, 31),
                                                        tour_id: @tour.id
                                                         })
      @expense8 = TM::Database.db.create_transaction({ amount: -450.00,
                                                        source: "check",
                                                        description: "Employee Pay",
                                                        date: Date.new(2014, 1, 31),
                                                        tour_id: @tour.id
                                                         })
      @expense9 = TM::Database.db.create_transaction({ amount: -350.00,
                                                        source: "check",
                                                        description: "Employee Pay",
                                                        date: Date.new(2014, 1, 31),
                                                        tour_id: @tour.id
                                                         })
    end

    it "calculates total cc transactions" do
      expect(@tour.cc_total).to eq(-252.00)
    end

    it "calculates total_gig_pay_towards_deposit" do
      expect(@tour.total_gig_pay_towards_deposit).to eq(2625.0)
    end

    it "calculates cash_in_out" do
      expect(@tour.cash_in_out).to eq(-470.0)
    end

    it "calculates booking_bill" do
      expect(@tour.booking_bill).to eq(255.00)
    end

    it "calculates deposit" do
      expect(@tour.deposit).to eq(2155.00)
    end

    it "calculates tour gross" do
      expect(@tour.gross).to eq(2665)
    end

    it "calculates tour net" do
      expect(@tour.net).to eq(888)
    end

    it "calculates booking_share" do
      expect(@tour.booking_share).to eq(255.00)
    end

    it "calculates total expeneses" do
      expect(@tour.expenses).to eq(-1522)
    end

    it "calculates credits" do
      expect(@tour.credits).to eq(0)
    end

    it "calculates manager-share" do
      expect(@tour.manager_share).to eq(0)
    end

  end
end
