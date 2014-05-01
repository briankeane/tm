require 'spec_helper'

module TM

  describe 'a badass database' do

    db = TM::Database::InMemory.new

    before { db.clear_everything }

    ##############
    #   Users    #
    ##############
    describe 'User' do
      it 'creates a User' do
        user = db.create_user ({ username: "Bob", password: "password" })
        expect(user.username).to eq("Bob")
        expect(user.password_digest).to eq("password")
        expect(user.id).to_not be_nil
      end

      it 'gets a User' do
        user = db.create_user ({ username: "Bob", password: "password" })
        expect(db.get_user(user.id).username).to eq("Bob")
      end

      it 'deletes a User' do
        user = db.create_user ({ username: "Bob", password: "password" })
        result = db.delete_user(user.id)
        expect(db.delete_user(999999)).to eq(false)
        expect(result).to eq(true)
        expect(db.get_user(user.id)).to be_nil
      end

      it 'gets a user by username' do
        user = db.create_user ({ username: "Bob", password: "password" })
        expect(db.get_user_by_username("Bob").id).to eq(user.id)
        expect(db.get_user_by_username("Billy")).to be_nil
      end
    end


    ##############
    #  Sessions  #
    ##############
    describe 'Session' do
      it 'creates a Session' do
        session_id = db.create_session(5)
        user_id = db.get_uid_from_sid(session_id)
        expect(user_id).to eq(5)
        expect(db.get_uid_from_sid(25)).to be_nil
      end


      it 'deletes a session' do
        session_id = db.create_session(5)
        expect(db.get_uid_from_sid(session_id)).to eq(5)
        db.delete_session(session_id)
        expect(db.get_uid_from_sid(session_id)).to be_nil
      end

    end

    ##############
    #   Artists  #
    ##############

    describe 'Artist' do
      it "creates an artist" do
        artist = db.create_artist ({ :name => 'Johnny', :manager_share => 0.15, :booking_share => 0.10 })
        expect(artist).to be_a TM::Artist
        expect(artist.name).to eq('Johnny')
        expect(artist.manager_share).to eq(0.15)
        expect(artist.booking_share).to eq(0.10)
      end

      it "gets an artist" do
        artist = db.create_artist ({ :name => 'Johnny', :manager_share => 0.15, :booking_share => 0.10 })
        retrieved_artist = db.get_artist(artist.id)
        expect(retrieved_artist.name).to eq('Johnny')
      end

      it "gets all artists" do
        artist = db.create_artist ({ :name => 'Johnny', :manager_share => 0.15, :booking_share => 0.10 })
        artist2 = db.create_artist ({ :name => 'Bob', :manager_share => 0.15, :booking_share => 0.10 })
        artist3 = db.create_artist ({ :name => 'Sue', :manager_share => 0.15, :booking_share => 0.10 })
        expect(db.all_artists.count).to eq(3)
        expect(db.all_artists.map &:name).to include('Johnny', 'Bob', 'Sue')
      end

      it "deletes an artist" do
        artist = db.create_artist ({ :name => 'Johnny', :manager_share => 0.15, :booking_share => 0.10 })
        employee = db.create_employee ({ first_name: 'Bob', last_name: 'Dole', ssn: '249-23-1524', artist_id: artist.id })
        expect(artist.name).to eq('Johnny')
        result = db.delete_artist(artist.id)
        result2 = db.delete_artist(99999)
        expect(result).to eq(true)
        expect(result2).to eq(false)
        expect(db.get_artist(artist.id)).to be_nil
        expect(db.get_employee(employee.id)).to be_nil
      end

      it "edits an artist" do
        artist = db.create_artist ({ :name => 'Johnny', :manager_share => 0.15, :booking_share => 0.10 })
        db.edit_artist({ artist_id: artist.id, name: 'Bobby' })
        expect(artist.name).to eq('Bobby')
        db.edit_artist({ artist_id: artist.id, manager_share: 0.95 })
        expect(artist.manager_share).to eq(0.95)
        db.edit_artist({ artist_id: artist.id, :booking_share => 0.80 })
        expect(artist.booking_share).to eq(0.80)
      end

      #########################
      #   User/Artist Join    #
      #########################

      it "establishes a user/artist relationship and gets all artists per user" do
        user = db.create_user ({ username: "Bob", password: "password" })
        artist = db.create_artist ({ :name => 'Johnny', :manager_share => 0.15, :booking_share => 0.10 })
        db.assign_user_artist_relationship({ user_id: user.id, artist_id: artist.id })
        expect(db.get_artists_by_user(user.id).size).to eq(1)
        expect(db.get_artists_by_user(user.id)[0].id).to eq(artist.id)
      end
    end


    ###############
    #    Tours    #
    ###############

    describe 'Tour' do
      it "creates a tour" do
        artist = db.create_artist ({ :name => 'Johnny', :manager_share => 0.15, :booking_share => 0.10 })
        tour = db.create_tour({ start_date: Date.new(2014, 4, 15), end_date: Date.new(2014, 4,17), artist_id: artist.id })
        expect(tour).to be_a TM::Tour
        expect(tour.start_date).to eq(Date.new(2014, 4, 15))
        expect(tour.end_date).to eq(Date.new(2014, 4,17))
        expect(tour.id).to_not be_nil
        expect(tour.artist_id).to eq(artist.id)
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

      it "deletes a tour and all it's gigs and transactions" do
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
        gig1 = db.create_gig({ venue: "Gruene Hall", city: "New Braunfels",
                      market: "Also New Braunfels", cc_sales: 50,
                      cash_sales: 100, deposit: 500, walk: 1000,
                      tips: 0, tour_id: tour.id })
        gig2 = db.create_gig({ venue: "The Firehouse", city: "New Braunfels",
                      market: "Also New Braunfels", cc_sales: 50,
                      cash_sales: 100, deposit: 500, walk: 1000,
                      tips: 0, tour_id: tour2.id  })
        result = db.delete_tour(tour.id)
        expect(result).to eq(true)
        expect(db.get_tour(tour.id)).to be_nil
        expect(db.get_transactions_by_tour(tour.id).length).to eq(0)
      end

      it "gets all tours for an artist" do
        artist = db.create_artist ({ :name => 'Johnny', :manager_share => 0.15, :booking_share => 0.10 })
        tour = db.create_tour({ start_date: Date.new(2014, 4, 15), end_date: Date.new(2014, 4,17), artist_id: artist.id })
        tour2 = db.create_tour({ start_date: Date.new(2014, 5, 15), end_date: Date.new(2014, 5,17), artist_id: artist.id })
        tour3 = db.create_tour({ start_date: Date.new(2014, 6, 15), end_date: Date.new(2014, 6,17), artist_id: artist.id })
        tour4 = db.create_tour({ start_date: Date.new(2014, 6, 16), end_date: Date.new(2014, 6,18), artist_id: (artist.id + 5) })
        tours = db.get_tours_by_artist(artist.id)
        expect(tours.size).to eq(3)
        expect(tours[0].start_date).to eq(Date.new(2014, 4, 15))
        expect(tours[2].start_date).to eq(Date.new(2014, 6, 15))
      end

      it "edits a tour" do
        artist = db.create_artist ({ :name => 'Johnny', :manager_share => 0.15, :booking_share => 0.10 })
        tour = db.create_tour({ start_date: Date.new(2014, 4, 15), end_date: Date.new(2014, 4,17), artist_id: artist.id })
        db.edit_tour({ tour_id: tour.id, start_date: Date.new(2012, 12, 12)})
        expect(tour.start_date).to eq(Date.new(2012, 12, 12))
        db.edit_tour({ tour_id: tour.id, end_date: Date.new(2014, 1,1 ) })
        expect(tour.end_date).to eq(Date.new(2014, 1, 1))
      end
    end


    ##################
    #  Transactions  #
    ##################

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

      it "deletes a transaction" do
        tour = db.create_tour({ start_date: Date.new(2014, 4, 15), end_date: Date.new(2014, 4,17) })
        transaction = db.create_transaction({ amount: 55.25, source: "cc", description: "Tips",
                                      date: Date.new(2014, 4, 15), tour_id: tour.id })
        result = db.delete_transaction(transaction.id)
        expect(result).to eq(true)
        expect(db.get_transaction(transaction.id)).to be_nil
      end

      it "edits a transaction" do
        tour = db.create_tour({ start_date: Date.new(2014, 4, 15), end_date: Date.new(2014, 4,17) })
        transaction = db.create_transaction({ amount: 55.25, source: "cc", description: "Tips",
                                      date: Date.new(2014, 4, 15), tour_id: tour.id })

        db.edit_transaction({ transaction_id: transaction.id, amount: 105.55 })

        expect(transaction.amount).to eq(105.55)
        db.edit_transaction({ transaction_id: transaction.id, source: "checking" })
        expect(transaction.amount).to eq(105.55)
        db.edit_transaction({ transaction_id: transaction.id, description: "OTHER", date: Date.new(2014,4,17) })
        expect(transaction.description).to eq("OTHER")
        expect(transaction.date).to eq(Date.new(2014, 4,17))
      end
    end


    ##################
    #    Employees   #
    ##################
    describe "Employee" do
      it "creates an employee" do
        employee = db.create_employee({ first_name: "Bob", last_name: "Dole",
                                        ssn: "249-35-2213", artist_id: 1 })
        expect(employee).to be_a TM::Employee
        expect(employee.id).to_not be_nil
        expect(employee.ssn).to eq("249-35-2213")
        expect(employee.first_name).to eq("Bob")
        expect(employee.last_name).to eq("Dole")
        expect(employee.artist_id).to eq(1)
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

      it "deletes an employee" do
        employee = db.create_employee({ first_name: "Bob", last_name: "Dole",
                                        ssn: "888-35-2213" })
        expect(db.get_employee(employee.id)).to_not be_nil
        result = db.delete_employee(employee.id)
        expect(result).to eq(true)
        expect(db.get_employee(employee.id)).to be_nil
      end

      it "edits an employee's info" do
        employee = db.create_employee({ first_name: "Bob", last_name: "Dole",
                                        ssn: "888-35-2213", artist_id: 5 })
        db.edit_employee({ employee_id: employee.id, first_name: 'Sue' })
        expect(employee.first_name).to eq("Sue")
        db.edit_employee({ employee_id: employee.id , last_name: 'Suskin' })
        expect(employee.last_name).to eq('Suskin')
        db.edit_employee({ employee_id: employee.id, ssn: "555-55-5555" })
        expect(employee.ssn).to eq("555-55-5555")
        db.edit_employee({ employee_id: employee.id, artist_id: 6 })
        expect(employee.artist_id).to eq(6)
      end
    end


    ##################
    #      Gigs      #
    ##################
    describe "gig" do
      it "creates a gig" do
        tour = db.create_tour({ start_date: Date.new(2014, 4, 15), end_date: Date.new(2014, 4,17) })

        gig = db.create_gig({ venue: "Gruene Hall", city: "New Braunfels",
                              market: "Also New Braunfels", cc_sales: 50,
                              cash_sales: 100, deposit: 500, walk: 1000,
                              tips: 0, type: "headliner", cover: 5, paid: 55, tour_id: tour.id,
                              other_bands: ["Randy Rogers Band", "Wade Bowen"] })
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
        expect(gig.other_bands).to eq(["Randy Rogers Band", "Wade Bowen"])
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

      it "deletes a gig" do
        tour = db.create_tour({ start_date: Date.new(2014, 4, 15), end_date: Date.new(2014, 4,17) })
        gig1 = db.create_gig({ venue: "Gruene Hall", city: "New Braunfels",
                      market: "Also New Braunfels", cc_sales: 50,
                      cash_sales: 100, deposit: 500, walk: 1000,
                      tips: 0, tour_id: tour.id })
        expect(db.get_gig(gig1.id)).to_not be_nil
        result = db.delete_gig(gig1.id)
        expect(result).to eq(true)
        expect(db.get_gig(gig1.id)).to be_nil
      end

      it "gets gigs by market" do
        artist = db.create_artist({ name: 'Bob' })
        tour = db.create_tour({ start_date: Date.new(2012, 4, 15), end_date: Date.new(2012, 4,17), artist_id: artist.id })
        tour2 = db.create_tour({ start_date: Date.new(2013, 5, 15), end_date: Date.new(2013, 5,17), artist_id: artist.id })
        tour3 = db.create_tour({ start_date: Date.new(2014, 4, 15), end_date: Date.new(2014, 4,17), artist_id: artist.id })
        tour4 = db.create_tour({ start_date: Date.new(2015, 4, 15), end_date: Date.new(2015, 4,17), artist_id: artist.id })

        gig1 = db.create_gig({ venue: "Gruene Hall", city: "New Braunfels",
                      market: "New Braunfels", cc_sales: 50,
                      cash_sales: 100, deposit: 500, walk: 1000,
                      tips: 0, tour_id: tour.id, date: Date.new(2012, 4,16) })
        gig2 = db.create_gig({ venue: "The Firehouse", city: "New Braunfels",
                      market: "New Braunfels", cc_sales: 50,
                      cash_sales: 100, deposit: 500, walk: 1000,
                      tips: 0, tour_id: tour2.id, date: Date.new(2013, 4,16) })
        gig3 = db.create_gig({ venue: "Blue Light", city: "New Braunfels",
                      market: "Lubbock", cc_sales: 50,
                      cash_sales: 100, deposit: 500, walk: 1000,
                      tips: 0, tour_id: tour3.id, date: Date.new(2014, 4,16) })
        gig4 = db.create_gig({ venue: "Gruene Hall", city: "New Braunfels",
                      market: "New Braunfels", cc_sales: 50,
                      cash_sales: 100, deposit: 500, walk: 1000,
                      tips: 0, tour_id: tour4.id, date: Date.new(2015, 4,16)  })
        gigs_by_market = db.get_gigs_by_market({ market: "New Braunfels", artist_id: artist.id })
        expect(gigs_by_market.size).to eq(3)
        expect(gigs_by_market[0].id).to eq(gig1.id)
        expect(gigs_by_market[2].id).to eq(gig4.id)
      end

      it "edits a gig" do
        gig = db.create_gig({ venue: "Gruene Hall", city: "New Braunfels",
                              market: "Also New Braunfels", cc_sales: 50,
                              cash_sales: 100, deposit: 500, walk: 1000,
                              tips: 0, type: "headliner", cover: 5, paid: 55, tour_id: 5,
                              other_bands: ["Randy Rogers Band", "Wade Bowen"] })
        db.edit_gig({ gig_id: gig.id, venue: "Blue Light", city: "Lubbock",
                                cc_sales: 100.00, cash_sales: 1000.00 })
        expect(gig.venue).to eq("Blue Light")
        expect(gig.city).to eq("Lubbock")
        expect(gig.cc_sales).to eq(100.00)
        expect(gig.cash_sales).to eq(1000.00)
        db.edit_gig({ gig_id: gig.id, deposit: 0, walk: 250, tips: 100, type: "support",
                                cover: 10, paid: 1150, tour_id: 8, other_bands: "Cody Johnson" })
        expect(gig.deposit).to eq(0)
        expect(gig.walk).to eq(250)
        expect(gig.tips).to eq(100)
        expect(gig.type).to eq("support")
        expect(gig.cover).to eq(10)
        expect(gig.paid).to eq(1150)
        expect(gig.tour_id).to eq(8)
        expect(gig.other_bands).to eq("Cody Johnson")
      end
    end
  end
end
