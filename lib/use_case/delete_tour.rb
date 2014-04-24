module TM
  class DeleteTour < UseCase
    def run(tour_id)
      case
      when TM::Database.db.get_tour(tour_id) == nil
        return failure :tour_not_found
      else
        TM::Database.db.delete_tour(tour_id)
        return success
      end
    end
  end
end
