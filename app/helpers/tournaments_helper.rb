module TournamentsHelper

  def organizer_title(tournament)
    "Organized by #{@tournament.organizer.name} Don't be shy, anyone can enroll!"
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

  def tournament_organized_title(tournament)
    if tournament.organizer == current_user
      "Organized #{tournament.sport.name}"
    else
      "#{tournament.sport.name}"
    end
  end

  def upcoming_tournaments_count(tournaments)
    if @tournaments.any?
      if Date.today.saturday? || Date.today.sunday?
        "#{pluralize(@tournaments.count, 'Tournament')} Next Weekend"
      else
        "#{pluralize(@tournaments.count, 'Tournament')} This Weekend"
      end
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

  def funding_total(tournament)
    "Funding total @ " + format_money(tournament.current_bet_amount) + "/" + format_money(tournament.total_bet_amount)
  end

  def options_for_days
    saturday =  Date.today.next_week.end_of_week - 1
    sunday = Date.today.next_week.end_of_week
    [
      [saturday.strftime("%A #{saturday.day.ordinalize}"),6],
      [sunday.strftime("%A #{sunday.day.ordinalize}"),7]
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
      ['$4','4'],
      ['$6','6'],
      ['$8','8']
    ]
  end

end
