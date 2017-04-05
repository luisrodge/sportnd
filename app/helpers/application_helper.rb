module ApplicationHelper

	def format_datetime(datetime)
		datetime.strftime("%A %b %d @ around %I:%M%p")
	end
end
