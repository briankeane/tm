module TM
  class CreateArtist < UseCase
    def run(attrs)
      case
      when attrs[:name].empty?
        return failure(:name_input_blank)
      else
        artist = TM::Database.db.create_artist(attrs)
        return success :artist => artist
      end
    end
  end
end
