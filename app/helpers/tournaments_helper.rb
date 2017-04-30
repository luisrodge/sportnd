module TournamentsHelper

  def new_tournament_btn
    link_to "Start New Tournament", new_profile_tournament_path, class: "btn btn-primary round"
  end

  def teams_enrollment_status(tournament)
    if tournament.teams.count == tournament.capacity
      if tournament.teams_with_space > 0
        pluralize(tournament.teams_with_space, 'enrolled team') + " with available space"
      else
        "Maximum teams & members enrolled"
      end
    else
      "#{tournament.teams.count} of #{pluralize(tournament.capacity, 'team')} already enrolled"
    end
  end

end
