module TM
  module Database

    def self.db
      @@db != InMemory.new
    end

    class InMemory

      def initialize(config=nil)
        clear_everything
      end

      def clear_everything
        @user_id_counter = 200
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
        @users = {}
        @user_artist = []
      end

      ##############
      #   Users    #
      ##############
      def create_user(attrs)
        id = (@user_id_counter += 1)
        attrs[:id] = id
        user = User.new(attrs)
        @users[user.id] = user
      end

      def get_user(id)
        @users[id]
      end

      def delete_user(id)
        if (@users.delete(id) != nil)
          return true
        else
          return false
        end
      end

      def assign_user_artist_relationship(user_id, artist_id)
        @user_artist << [user_id, artist_id]
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

      def delete_artist(id)   # deletes an artist and all their tours
        if (@artists.delete(id) == nil)
          return false
        else
          tours_for_deletion = @tours.values.select { |t| t.artist_id == id }
          tours_for_deletion.each { |t| self.delete_tour(tour.id) }
          @employees.delete_if { |k, v| v.artist_id == id }

        end
        return true
      end

      def get_artists_by_user(user_id)
        results = []
        @user_artist.each do |x|
          if x[0] == user_id
            results << self.get_artist(x[1])
          end
        end
        return results
      end

      def edit_artist(attrs)
        artist = self.get_artist(attrs[:artist_id])
        if attrs[:name]           then  artist.name = attrs[:name]                      end
        if attrs[:manager_share]  then  artist.manager_share = attrs[:manager_share]    end
        if attrs[:booking_share]  then  artist.booking_share = attrs[:booking_share]    end
        artist
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

      def delete_tour(id)   #deletes a tour and all its transactions and gigs
        if @tours.delete(id) == nil
          return false
        else
          @transactions.delete_if { |k,v| v.tour_id == id }
          @gigs.delete_if { |k,v| v.tour_id == id }
        end
        return true
      end

      def get_tours_by_artist(artist_id)
        return @tours.values.select { |v| v.artist_id == artist_id }.sort_by { |x| x.start_date }
      end

      def edit_tour(attrs)
        tour = self.get_tour(attrs[:tour_id])
        if attrs[:start_date]       then  tour.start_date = attrs[:start_date]    end
        if attrs[:end_date]         then  tour.end_date = attrs[:end_date]        end
        if attrs[:artist_id]        then  tour.artist_id = attrs[:artist_id]    end
        tour
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

      def delete_transaction(id)
        if @transactions.delete(id) != nil
          return true
        else
          return false
        end
      end

      ##################
      #    Employees   #
      ##################
      def create_employee(attrs)   #first_name, last_name, ssn, artist_id
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

      def delete_employee(id)
        if @employees.delete(id) != nil
          return true
        else
          return false
        end
      end

      def edit_employee(attrs)
        employee = self.get_employee(attrs[:employee_id])
        if attrs[:first_name]     then  employee.first_name = attrs[:first_name]          end
        if attrs[:last_name]      then  employee.last_name = attrs[:last_name]    end
        if attrs[:ssn]            then  employee.ssn = attrs[:ssn]    end
        if attrs[:artist_id]      then  employee.artist_id = attrs[:artist_id]            end
        employee
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

      def delete_gig(id)
        if @gigs.delete(id) != nil
          return true
        else
          return false
        end
      end

    end

    def self.db
      @__db_instance ||= InMemory.new
    end

  end
end
