module VenuesHelper

  def tournaments_this_week(venue)
    if venue.tournaments_this_week.any?
      pluralize(venue.tournaments_this_week.count, "Tournament") + " This Weekend"
    else
      "No Tournaments This Weekend"
    end
  end

end
