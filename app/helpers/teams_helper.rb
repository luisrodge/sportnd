module TeamsHelper

  # Join button for a team enrolled in a tournament
  def join_btn(tournament, team, size)
    if user_signed_in?
      if !tournament.enrolled?(current_user) && team.users.count < tournament.team_size && !current_user.has_tournament_this_date?(tournament)
        link_to "Join", join_profile_team_path(team), method: :put, class: "btn btn-primary btn-#{size} btn-block round"
      end
    else
      link_to "Join", join_profile_team_path(team), method: :put, class: "btn btn-primary btn-#{size} btn-block round"
    end
  end

  def leave_team_btn(tournament)
    if tournament.organizer != current_user
      link_to "Leave Team", leave_profile_team_path(current_user.team_for_tournament(@tournament)), data: { confirm: 'Are you sure?','sweet-alert-type': 'warning', text: 'You are about to leave this team & tournament', 'confirm-button-color': '#EE543A' }, method: :delete, class: "btn btn-danger btn-xs round"
    end
  end

  def leave_tournament_btn(tournament, team)
		if team.users.exists?(current_user) && tournament.organizer != current_user && team.captain == current_user
			link_to "Leave Tournament", profile_tournament_team_path(tournament, team), method: :delete, data: { confirm: 'Are you sure?','sweet-alert-type': 'warning', text: 'You are about to remove your team from this tournament', 'confirm-button-color': '#EE543A' }, class: "btn btn-danger btn-xs round"
		end
	end

end
