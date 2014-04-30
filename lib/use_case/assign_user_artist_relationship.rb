module TM
  class AssignUserArtistRelationship < UseCase
    def run(attrs)
      case
      when TM::Database.db.get_artist(attrs[:artist_id]) == nil
        return failure :artist_not_found
      when TM::Database.db.get_user(attrs[:user_id]) == nil
        return failure :user_not_found
      else
      employee = TM::Database.db.assign_user_artist_relationship(attrs)
      return success
      end
    end
  end
end
