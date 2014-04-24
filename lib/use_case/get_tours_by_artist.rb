module TM
  class GetToursByArtist < UseCase
    def run(artist_id)
      case
      when TM::Database.db.get_artist(artist_id) == nil
        return failure :artist_not_found
      else
        return success :tours => (TM::Database.db.get_tours_by_artist(artist_id))
      end
    end
  end
end
