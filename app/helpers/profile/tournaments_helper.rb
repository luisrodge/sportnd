module Profile::TournamentsHelper

	def money_format(money)
		number_to_currency(money, :unit => "$") 
	end

end
