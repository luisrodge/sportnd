class Venue < ApplicationRecord
	mount_uploader :venue_image, VenueImageUploader
end
