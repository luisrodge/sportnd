module TeamsHelper

  def join_btn(team, btn_size)
    if current_member
      if policy(Membership.where(team: team).first).create?
        button_to "Join", profile_team_memberships_path(team), method: :post, class: "btn btn-primary btn-#{btn_size} btn-block round"
      end
    else
      if team.tournament.enrollment_period? && team.remaining_space > 0
        button_to "Join", profile_team_memberships_path(team), method: :post, class: "btn btn-primary btn-#{btn_size} btn-block round"
      end
    end
  end

  def leave_team_btn(tournament)
    if tournament.organizer != current_member
      link_to "Leave Team", profile_team_membership_path(current_member.team_for_tournament(@tournament)), data: { confirm: 'Are you sure?','sweet-alert-type': 'warning', text: 'You are about to leave this team & tournament', 'confirm-button-color': '#EE543A' }, method: :delete, class: "btn btn-danger btn-xs round"
    end
  end

  def leave_tournament_btn(tournament, team)
		if team.members.exists?(current_member) && tournament.organizer != current_member && team.captain == current_member
			link_to "Leave Tournament", profile_tournament_team_path(tournament, team), method: :delete, data: { confirm: 'Are you sure?','sweet-alert-type': 'warning', text: 'You are about to remove your team and all members from this tournament', 'confirm-button-color': '#EE543A' }, class: "btn btn-danger btn-xs round"
		end
	end

  def team_available_space(team)
    if team.remaining_space > 0
      pluralize(team.remaining_space, "Space")
    else
      "Full"
    end
  end

  def teams_enrolled_count
    Team.enrolled_in_tournaments.each.count
  end

end
