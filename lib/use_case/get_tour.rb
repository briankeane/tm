module TM
  class GetTour < UseCase
    def run(tour_id)
      tour = TM::Database.db.get_tour(tour_id)
      case
      when tour == nil
        return failure :tour_not_found
      else
        return success :tour => tour
      end
    end
  end
end
