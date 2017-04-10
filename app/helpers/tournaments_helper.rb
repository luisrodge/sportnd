module TournamentsHelper

	def leave_btn(tournament, team)
		if user_signed_in?
			if team.users.exists?(current_user) && team.captain == current_user
				link_to "Leave Tournament", profile_tournament_team_path(tournament, team), method: :delete, class: "btn btn-danger btn-xs round"
			end
		end
	end
end
