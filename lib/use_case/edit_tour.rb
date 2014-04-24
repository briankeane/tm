module TM
  class EditTour < UseCase
    def run(attrs)
      if TM::Database.db.get_tour(attrs[:tour_id]) == nil
        return failure :tour_not_found
      else
        tour = TM::Database.db.edit_tour(attrs)
        return success :tour => tour
      end
    end
  end
end
