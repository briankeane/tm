require 'pry-debugger'
module TM
  class SignIn < UseCase
    def run(attrs)
      user = TM::Database.db.get_user_by_username(attrs[:username])
      case
      when user == nil
        return failure(:username_not_found)
      when user.password_correct?(attrs[:password]) == false
        return failure(:incorrect_password)
      else
        session_id = TM::Database.db.create_session(user.id)
        return success :session_id => session_id, :user => user
      end
    end
  end
end
