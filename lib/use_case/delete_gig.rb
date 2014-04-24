module TM
  class DeleteGig < UseCase
    def run(gig_id)
      if TM::Database.db.get_gig(gig_id) == nil
        return failure :gig_not_found
      else
        TM::Database.db.delete_gig(gig_id)
        return success
      end
    end
  end
end
