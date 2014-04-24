module TM
  class GetArtist < UseCase
    def run(artist_id)
      artist = TM::Database.db.get_artist(artist_id)
      case artist
      when nil
        return failure :artist_not_found
      else
        return success :artist => artist
      end
    end
  end
end

