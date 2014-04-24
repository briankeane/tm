require 'spec_helper'

describe 'EditTransaction' do
  it "calls bullshit if transaction not found" do
    result = TM::EditTransaction.run({ transaction_id: 99999, amount: 20.00 })
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:transaction_not_found)
  end

  it "changes a transaction's info" do
    tour = TM::Database.db.create_tour({ start_date: Date.new(2014, 4, 15), end_date: Date.new(2014, 4,17) })
    transaction = TM::Database.db.create_transaction({ amount: 55.25, source: "cc", description: "Tips",
                                  date: Date.new(2014, 4, 15), tour_id: tour.id })

    result = TM::EditTransaction.run({ transaction_id: transaction.id, amount: 105.55 })
    expect(result.success?).to eq(true)
    expect(result.transaction.amount).to eq(105.55)
    result = TM::EditTransaction.run({ transaction_id: transaction.id, source: "checking" })
    expect(transaction.amount).to eq(105.55)
    result = TM::EditTransaction.run({ transaction_id: transaction.id, description: "OTHER", date: Date.new(2014,4,17) })
    expect(result.transaction.description).to eq("OTHER")
    expect(transaction.date).to eq(Date.new(2014, 4,17))
  end
end
