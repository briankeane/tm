module TM
  class GetArtistsByUser < UseCase
    def run(user_id)
      case
      when TM::Database.db.get_user(user_id) == nil
        return failure(:user_not_found)
      else
        artists = TM::Database.db.get_artists_by_user(user_id)
        return success :artists => artists
      end
    end
  end
end
