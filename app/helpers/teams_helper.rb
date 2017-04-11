module TeamsHelper

  # Join button for a team enrolled in a tournament
  def join_btn(tournament, team)
    if user_signed_in?
      if !tournament.enrolled?(current_user)
        link_to "Join", join_profile_team_path(team), method: :put, class: "btn btn-primary btn-xs btn-block round"
      end
    else
      link_to "Join", join_profile_team_path(team), method: :put, class: "btn btn-primary btn-xs btn-block round"
    end
  end

  def leave_tournament_btn(tournament, team)
		if user_signed_in?
			if team.users.exists?(current_user) && team.captain == current_user
				link_to "Leave Tournament", profile_tournament_team_path(tournament, team), method: :delete, data: { confirm: 'Are you sure?','sweet-alert-type': 'warning', text: 'You are about to remove your team from this tournament', 'confirm-button-color': '#EE543A' }, class: "btn btn-danger btn-xs round"
			end
		end
	end

end
