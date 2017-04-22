module ApplicationHelper

	def format_datetime(date, time)
		date.strftime("%A %b %d") + " @ around " + time.strftime("%I:%M%p")
	end
	
end
