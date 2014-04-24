module TM
  class EditGig < UseCase
    def run(attrs)
      if TM::Database.db.get_gig(attrs[:gig_id]) == nil
        return failure(:gig_not_found)
      else
        gig = TM::Database.db.edit_gig(attrs)
        return success :gig => gig
      end
    end
  end
end
