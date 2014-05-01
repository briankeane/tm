require '../lib/tm.rb'


if TM::Database.db.is_a?(TM::Database::InMemory)
  @user = TM::Database.db.create_user({ username: "Bob", password: "password" })

  @artist1 = TM::Database.db.create_artist({ name: "Brian Keane", manager_share: 0,
                                  booking_share: 0.10 })
  @artist2 = TM::Database.db.create_artist({ name: "Bob Dylan", manager_share: 0.20, booking_share: 0.7 })
  @artist3 = TM::Database.db.create_artist({ name: "Queen", manager_share: 0.1, booking_share: 0.2 })
  TM::Database.db.assign_user_artist_relationship({ user_id: @user.id, artist_id: @artist1.id })
  TM::Database.db.assign_user_artist_relationship({ user_id: @user.id, artist_id: @artist2.id })
  TM::Database.db.assign_user_artist_relationship({ user_id: @user.id, artist_id: @artist3.id })

  @tour = TM::Database.db.create_tour({ start_date: Date.new(2014, 1, 29), end_date: Date.new(2014, 1, 31), artist_id: @artist1.id })
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
