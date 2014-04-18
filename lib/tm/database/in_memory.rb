module TM
  module Database
    class InMemory

      def initialize(config=nil)
        clear_everything
      end

      def clear_everything
        @artist_id_counter = 100
        @tour_id_counter = 500
        @transaction_id_counter = 800
        @employee_id_counter = 10
        @gig_id_counter = 300
        @artists = {}
        @tours = {}
        @transactions = {}
        @employees = {}
        @gigs = {}
      end


      ##############
      #   Artists  #
      ##############

      def create_artist(attrs)
        id = (@artist_id_counter += 1)
        attrs[:id] = id
        artist = Artist.new(attrs)
        @artists[artist.id] = artist
      end

      def get_artist(id)
        return @artists[id]
      end

      def all_artists
        return @artists.values
      end

      ###############
      #    Tours    #
      ###############

      def create_tour(attrs)  #start_date, #end_date
        id = (@tour_id_counter += 1)
        attrs[:id] = id
        new_tour = Tour.new(attrs)
        @tours[new_tour.id] = new_tour
      end

      def get_tour(id)
        return @tours[id]
      end

      def all_tours
        return @tours.values
      end

      ##################
      #  Transactions  #
      ##################

      def create_transaction(attrs)  #amount, source, description, date, tour_id
        id = (@transaction_id_counter += 1)
        attrs[:id] = id
        new_transaction = Transaction.new(attrs)
        @transactions[id] = new_transaction
        return new_transaction
      end

      def get_transaction(id)
        return @transactions[id]
      end

      def get_transactions_by_tour(id)
        return @transactions.values.select { |t| t.tour_id == id }
      end

      ##################
      #    Employees   #
      ##################
      def create_employee(attrs)
        id = (@employee_id_counter += 1)
        attrs[:id] = id
        new_employee = Employee.new(attrs)
        @employees[new_employee.id] = new_employee
        new_employee
      end

      def get_employee(id)
        @employees[id]
      end

      def all_employees
        @employees.values
      end

      ##################
      #      Gigs      #
      ##################
      def create_gig(attrs) # venue, city, market, cc_sales, cash_sales
                            # deposit, walk, tips, cover, paid, type, other_bands
        id = (@gig_id_counter += 1)
        attrs[:id] = id
        gig = Gig.new(attrs)
        @gigs[gig.id] = gig
        gig
      end

      def get_gig(id)
        @gigs[id]
      end

      def get_gigs_by_tour(tour_id)
        @gigs.values.select{ |x| x.tour_id == tour_id }
      end
    end

    def self.db
      @__db_instance ||= InMemory.new
    end

  end
end
