module TM
  module Database
    class InMemory

      def initialize(config=nil)
        clear_everything
      end

      def clear_everything
        @user_id_counter = 100
        @tour_id_counter = 500
        @transaction_id_counter = 800
        @employee_id_counter = 10
        @gig_id_counter = 300
        @users = {}
        @tours = {}
        @transactions = {}
        @employees = {}
        @gigs = {}
      end


      ##############
      #   Users    #
      ##############

      def create_user(attrs)
        id = (@user_id_counter += 1)
        attrs[:id] = id
        new_user = User.new(attrs)
        @users[new_user.id] = new_user
      end

      def get_user(id)
        return @users[id]
      end

      def all_users
        return @users.values
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
                            # deposit, walk, tips, cover, paid, type
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
  end
end
