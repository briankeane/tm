require 'spec_helper'

module TM

  describe 'a badass database' do

    db = TM::Database::InMemory.new

    before { db.clear_everything }

    describe 'User' do
      it "creates a user" do
        user = db.create_user ({ :username => 'Johnny', :password => 'password' })
        expect(user).to be_a TM::User
        expect(user.username).to eq('Johnny')
        expect(user.password).to eq('password')
        expect(user.id).to_not be_nil
      end

      it "gets a user" do
        user = db.create_user ({ :username => 'Johnny', :password => 'password' })
        retrieved_user = db.get_user(user.id)
        expect(retrieved_user.username).to eq('Johnny')
      end

      it "gets all users" do
        user = db.create_user ({ :username => 'Johnny', :password => 'password' })
        user2 = db.create_user ({ :username => 'Bob', :password => 'bobspassword' })
        user3 = db.create_user ({ :username => 'Sue', :password => 'suespassword' })
        expect(db.all_users.count).to eq(3)
        expect(db.all_users.map &:username).to include('Johnny', 'Bob', 'Sue')
      end
    end

    describe 'Tour' do
      it "creates a tour" do
        tour = db.create_tour({ start_date: Date.new(2014, 4, 15), end_date: Date.new(2014, 4,17) })
        expect(tour).to be_a TM::Tour
        expect(tour.start_date).to eq(Date.new(2014, 4, 15))
        expect(tour.end_date).to eq(Date.new(2014, 4,17))
        expect(tour.id).to_not be_nil
      end

      it "gets a tour" do
        tour = db.create_tour({ start_date: Date.new(2014, 4, 15), end_date: Date.new(2014, 4,17) })
        retrieved_tour = db.get_tour(tour.id)
        expect(retrieved_tour.start_date).to eq(Date.new(2014, 4, 15))
      end

      it "gets all tours" do
        tour = db.create_tour({ start_date: Date.new(2014, 4, 15), end_date: Date.new(2014, 4,17) })
        tour2 = db.create_tour({ start_date: Date.new(2014, 5, 15), end_date: Date.new(2014, 5,17) })
        tour3 = db.create_tour({ start_date: Date.new(2014, 6, 15), end_date: Date.new(2014, 6,17) })
        expect(db.all_tours.count).to eq(3)
        expect(db.all_tours.map &:start_date).to include(Date.new(2014, 4, 15), Date.new(2014, 5, 15), Date.new(2014, 6, 15))
      end
    end

    describe 'Transactions' do
      it "creates a transaction" do
        tour = db.create_tour({ start_date: Date.new(2014, 4, 15), end_date: Date.new(2014, 4,17) })
        transaction = db.create_transaction({ amount: 55.25, source: "cc", description: "Gas",
                                      date: Date.new(2014, 4, 15), tour_id: tour.id })
        expect(transaction).to be_a TM::Transaction
        expect(transaction.amount).to eq(55.25)
        expect(transaction.source).to eq("cc")
        expect(transaction.description).to eq("Gas")
        expect(transaction.tour_id).to eq(tour.id)
        expect(transaction.date).to eq(Date.new(2014, 4, 15))
      end

      it "gets a transaction" do
        tour = db.create_tour({ start_date: Date.new(2014, 4, 15), end_date: Date.new(2014, 4,17) })
        transaction = db.create_transaction({ amount: 55.25, source: "cc", description: "Gas",
                                      date: Date.new(2014, 4, 15), tour_id: tour.id })
        retrieved_transaction = db.get_transaction(transaction.id)
        expect(retrieved_transaction.amount).to eq(55.25)
      end

      it "gets transactions by tour" do
        tour = db.create_tour({ start_date: Date.new(2014, 4, 15), end_date: Date.new(2014, 4,17) })
        tour2 = db.create_tour({ start_date: Date.new(2014, 5, 15), end_date: Date.new(2014, 5,17) })
        transaction = db.create_transaction({ amount: 55.25, source: "cc", description: "Tips",
                                      date: Date.new(2014, 4, 15), tour_id: tour.id })
        transaction2 = db.create_transaction({ amount: 65.25, source: "cash", description: "Bar Tab",
                                      date: Date.new(2014, 4, 15), tour_id: tour.id })
        transaction3 = db.create_transaction({ amount: 75.25, source: "checking", description: "Gas",
                                      date: Date.new(2014, 4, 15), tour_id: tour.id })
        transaction4 = db.create_transaction({ amount: 85.25, source: "cc", description: "Gas",
                                      date: Date.new(2014, 4, 15), tour_id: tour2.id })
        expect(db.get_transactions_by_tour(tour.id).length).to eq(3)
        expect(db.get_transactions_by_tour(tour2.id).length).to eq(1)
        expect(db.get_transactions_by_tour(tour.id).map &:amount).to include(55.25, 65.25, 75.25)
      end
    end

    describe "Employee" do
      it "creates an employee" do
        employee = db.create_employee({ first_name: "Bob", last_name: "Dole",
                                        ssn: "249-35-2213" })
        expect(employee).to be_a TM::Employee
        expect(employee.id).to_not be_nil
        expect(employee.ssn).to eq("249-35-2213")
        expect(employee.first_name).to eq("Bob")
        expect(employee.last_name).to eq("Dole")
      end

      it "gets an employee" do
        employee = db.create_employee({ first_name: "Bob", last_name: "Dole",
                                        ssn: "249-35-2213" })
        expect(db.get_employee(employee.id).first_name).to eq("Bob")
      end

      it "gets all employees" do
        employee = db.create_employee({ first_name: "Bob", last_name: "Dole",
                                        ssn: "888-35-2213" })
        employee2 = db.create_employee({ first_name: "Bill", last_name: "Clinton",
                                        ssn: "777-35-2213" })
        employee3 = db.create_employee({ first_name: "Cindy", last_name: "Crawford",
                                        ssn: "555-35-2213" })
        expect(db.all_employees.size).to eq(3)
        expect(db.all_employees.map &:first_name).to include("Bob", "Bill", "Cindy")
      end
    end

    describe "gig" do
      it "creates a gig" do
        tour = db.create_tour({ start_date: Date.new(2014, 4, 15), end_date: Date.new(2014, 4,17) })

        gig = db.create_gig({ venue: "Gruene Hall", city: "New Braunfels",
                              market: "Also New Braunfels", cc_sales: 50,
                              cash_sales: 100, deposit: 500, walk: 1000,
                              tips: 0, type: "headliner", cover: 5, paid: 55, tour_id: tour.id })
        expect(gig.id).to_not be_nil
        expect(gig).to be_a TM::Gig
        expect(gig.venue).to eq("Gruene Hall")
        expect(gig.city).to eq("New Braunfels")
        expect(gig.market).to eq("Also New Braunfels")
        expect(gig.cc_sales).to eq(50)
        expect(gig.cash_sales).to eq(100)
        expect(gig.deposit).to eq(500)
        expect(gig.walk).to eq(1000)
        expect(gig.tips).to eq(0)
        expect(gig.type).to eq("headliner")
        expect(gig.cover).to eq(5)
        expect(gig.paid).to eq(55)
        expect(gig.tour_id).to eq(tour.id)
      end

      it "gets a gig" do
        gig = db.create_gig({ venue: "Gruene Hall", city: "New Braunfels",
                      market: "Also New Braunfels", cc_sales: 50,
                      cash_sales: 100, deposit: 500, walk: 1000,
                      tips: 0 })
        retrieved_gig = db.get_gig(gig.id)
        expect(retrieved_gig.deposit).to eq(500)
        expect(retrieved_gig.venue).to eq("Gruene Hall")
      end

      it "gets_gigs_by_tour" do
        tour = db.create_tour({ start_date: Date.new(2014, 4, 15), end_date: Date.new(2014, 4,17) })
        tour2 = db.create_tour({ start_date: Date.new(2014, 5, 15), end_date: Date.new(2014, 5,17) })

        gig1 = db.create_gig({ venue: "Gruene Hall", city: "New Braunfels",
                      market: "Also New Braunfels", cc_sales: 50,
                      cash_sales: 100, deposit: 500, walk: 1000,
                      tips: 0, tour_id: tour.id })
        gig2 = db.create_gig({ venue: "The Firehouse", city: "New Braunfels",
                      market: "Also New Braunfels", cc_sales: 50,
                      cash_sales: 100, deposit: 500, walk: 1000,
                      tips: 0, tour_id: tour.id  })
        gig3 = db.create_gig({ venue: "Blue Light", city: "New Braunfels",
                      market: "Also New Braunfels", cc_sales: 50,
                      cash_sales: 100, deposit: 500, walk: 1000,
                      tips: 0, tour_id: tour.id })
        gig3 = db.create_gig({ venue: "Gruene Hall", city: "New Braunfels",
                      market: "Also New Braunfels", cc_sales: 50,
                      cash_sales: 100, deposit: 500, walk: 1000,
                      tips: 0, tour_id: tour2.id  })
        expect(db.get_gigs_by_tour(tour.id).size).to eq(3)
        expect(db.get_gigs_by_tour(tour.id).map &:venue).to include("Gruene Hall", "The Firehouse", "Blue Light")
        expect(db.get_gigs_by_tour(tour2.id).size).to eq(1)
      end










    end
  end
end
