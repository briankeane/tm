require 'spec_helper'

module TM

  describe 'GetTransactionsByTour' do
    it "Calls bullshit if the tour is not found" do
      result = TM::GetTransactionsByTour.run(99999)
      expect(result.success?).to eq(false)
      expect(result.error).to eq(:tour_not_found)
    end

    it "Creates an Artist if everything is correct" do
      tour = TM::Database.db.create_tour({ start_date: Date.new(2014, 4, 15), end_date: Date.new(2014, 4,17) })
      tour2 = TM::Database.db.create_tour({ start_date: Date.new(2014, 5, 15), end_date: Date.new(2014, 5,17) })
      transaction = TM::Database.db.create_transaction({ amount: 55.25, source: "cc", description: "Tips",
                                    date: Date.new(2014, 4, 15), tour_id: tour.id })
      transaction2 = TM::Database.db.create_transaction({ amount: 65.25, source: "cash", description: "Bar Tab",
                                    date: Date.new(2014, 4, 15), tour_id: tour.id })
      transaction3 = TM::Database.db.create_transaction({ amount: 75.25, source: "checking", description: "Gas",
                                    date: Date.new(2014, 4, 15), tour_id: tour.id })
      transaction4 = TM::Database.db.create_transaction({ amount: 85.25, source: "cc", description: "Gas",
                                    date: Date.new(2014, 4, 15), tour_id: tour2.id })

      result = TM::GetTransactionsByTour.run(tour.id)
      expect(result.success?).to eq(true)
      expect(result.transactions.size).to eq(3)
      expect(result.transactions[0].id).to eq(transaction.id)
    end

  end
end
