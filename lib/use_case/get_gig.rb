module TM
  class GetGig < UseCase
    def run(gig_id)
      gig = TM::Database.db.get_gig(gig_id)
      case gig
      when nil
        return failure :gig_not_found
      else
        return success :gig => gig
      end
    end
  end
end
