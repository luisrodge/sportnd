module Profile::TournamentsHelper

	def money_format(money)
		number_to_currency(money, :unit => "$")
	end

	def organized_enrolled_txt(tournament)
		if tournament.organizer == current_user && tournament.enrolled?(tournament)
			return "Organized & Enrolled"
		end
		"Enrolled"
	end

end
