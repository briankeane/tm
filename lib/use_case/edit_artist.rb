module TM
  class EditArtist < UseCase
    def run(attrs)
      if TM::Database.db.get_artist(attrs[:artist_id]) == nil
        return failure(:artist_not_found)
      else artist = TM::Database.db.edit_artist(attrs)
        return success :artist => artist
      end
    end
  end
end

