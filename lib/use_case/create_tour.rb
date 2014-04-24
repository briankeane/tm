module TM
  class CreateTour < UseCase
    def run(attrs)
      case
      when attrs[:start_date].is_a?(Date) == false
        return failure :start_date_invalid
      when TM::Database.db.get_artist(attrs[:artist_id]) == nil
        return failure :artist_not_found
      else
        tour = TM::Database.db.create_tour(attrs)
        return success :tour => tour
      end
    end
  end
end
