module TM
  class GetTransactionsByTour < UseCase
    def run(tour_id)
      case
      when TM::Database.db.get_tour(tour_id) == nil
        return failure :tour_not_found
      else
        transactions = TM::Database.db.get_transactions_by_tour(tour_id)
        return success :transactions => transactions
      end
    end
  end
end
