class Venue < ApplicationRecord
	mount_uploader :venue_image, VenueImageUploader

	has_many :tournaments

	def tournaments_this_week
		tournaments.where("Date(date) BETWEEN ? AND ?", Date.today.end_of_week.to_date - 2, Date.today.end_of_week.to_date)
	end

end
