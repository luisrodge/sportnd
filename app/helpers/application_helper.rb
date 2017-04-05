module ApplicationHelper

	def format_datetime(datetime)
		datetime.strftime("%A %b %d @ Around %I:%M%p")
	end
end
