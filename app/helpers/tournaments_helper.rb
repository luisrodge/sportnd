module TournamentsHelper

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

  def tournament_organized_title(tournament)
    if tournament.organizer == current_user
      "Organized #{tournament.sport.name}"
    else
      "#{tournament.sport.name}"
    end
  end

  def profile_tournament_date(tournament)
    if tournament.date.to_date == Date.tomorrow
      "Tomorrow @ around #{tournament.time.strftime("%I:%M%p")}"
    elsif tournament.date.to_date == Date.today
      "Today @ around #{tournament.time.strftime("%I:%M%p")}"
    else
      tournament.date.strftime("%A %b %d") + " @ around " + tournament.time.strftime("%I:%M%p")
    end
  end

  def options_for_weeks
    [
      ['Next Week',14],
      ['Next 2 Weeks',21]
    ]
  end

  def options_for_days
    [
      ['Saturday',6],
      ['Sunday',7]
    ]
  end

  def options_for_team_enrolls
    [
      ['2 Teams','2'],
      ['4 Teams','4']
    ]
  end

  def options_for_team_members
    [
      ['2 Members','2'],
      ['3 Members','3']
    ]
  end

  def options_for_bet_amount
    [
      ['$3','3'],
      ['$4','4'],
      ['$5','5']
    ]
  end

end
