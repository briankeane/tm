require 'securerandom'

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
        @session_id_count = 350
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
        @sessions = {}
      end

      ##############
      #   Users    #
      ##############
      def create_user(attrs)  # username, password
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

      def get_user_by_username(username)
        @users.values.select { |user| user.username == username }[0]
      end

      ##############
      #  Sessions  #
      ##############

      def create_session(user_id)
        session_id = SecureRandom.uuid
        @sessions[session_id] = user_id
        return session_id
      end

      def get_uid_from_sid(session_id)
        @sessions[session_id]
      end

      def delete_session(session_id)
        if @sessions[session_id]
          @sessions.delete(session_id)
          return true
        else
          return false
        end
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
          if x[:user_id] == user_id
            results << self.get_artist(x[:artist_id])
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

      #########################
      #   User/Artist Join    #
      #########################

      def assign_user_artist_relationship(attrs)
        @user_artist << { user_id: attrs[:user_id], artist_id: attrs[:artist_id] }
      end


      ###############
      #    Tours    #
      ###############

      def create_tour(attrs)  #start_date, #end_date
        id = (@tour_id_counter += 1)
        attrs[:id] = id
        new_tour = Tour.new(attrs)
        @tours[new_tour.id] = new_tour
        new_tour
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

      def edit_transaction(attrs)
        transaction = self.get_transaction(attrs[:transaction_id])
        if attrs[:amount]         then    transaction.amount = attrs[:amount]           end
        if attrs[:source]         then    transaction.source = attrs[:source]           end
        if attrs[:description]    then    transaction.description = attrs[:description] end
        if attrs[:date]           then    transaction.date = attrs[:date]               end
        transaction
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
        if attrs[:first_name]     then  employee.first_name = attrs[:first_name]      end
        if attrs[:last_name]      then  employee.last_name = attrs[:last_name]        end
        if attrs[:ssn]            then  employee.ssn = attrs[:ssn]                    end
        if attrs[:artist_id]      then  employee.artist_id = attrs[:artist_id]        end
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

      def get_gigs_by_market(attrs)  # market, artist_id
        gigs = @gigs.values.select{ |gig| (gig.market == attrs[:market]) && (self.get_tour(gig.tour_id).artist_id == attrs[:artist_id]) }.sort_by { |gig| gig.date }
      end

      def edit_gig(attrs)
        gig = self.get_gig(attrs[:gig_id])
        if attrs[:venue]          then    gig.venue = attrs[:venue]               end
        if attrs[:city]           then    gig.city = attrs[:city]                 end
        if attrs[:market]         then    gig.market = attrs[:market]             end
        if attrs[:cc_sales]       then    gig.cc_sales = attrs[:cc_sales]         end
        if attrs[:cash_sales]     then    gig.cash_sales = attrs[:cash_sales]     end
        if attrs[:deposit]        then    gig.deposit = attrs[:deposit]           end
        if attrs[:walk]           then    gig.walk = attrs[:walk]                 end
        if attrs[:tips]           then    gig.tips = attrs[:tips]                 end
        if attrs[:type]           then    gig.type = attrs[:type]                 end
        if attrs[:cover]          then    gig.cover = attrs[:cover]               end
        if attrs[:paid]           then    gig.paid = attrs[:paid]                 end
        if attrs[:tour_id]        then    gig.tour_id = attrs[:tour_id]           end
        if attrs[:other_bands]    then    gig.other_bands = attrs[:other_bands]   end
        gig
      end
    end

    def self.db
      @__db_instance ||= InMemory.new
    end

  end
end
