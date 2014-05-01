module TM
  class SignOut < UseCase
    def run(attrs)
      TM::Database.db.delete_session(attrs[:session_id])
      return success
    end
  end
end
