module TM
  class DeleteArtist < UseCase
    def run(artist_id)
      if TM::Database.db.get_artist(artist_id) == nil
        return failure :artist_not_found
      else
        TM::Database.db.delete_artist(artist_id)
        return success
      end
    end
  end
end
