module ApplicationHelper

	def format_datetime(date, time)
		date.strftime("%A %b %d") + " @ around " + time.strftime("%I:%M%p")
	end

	def format_date(date)
		date.strftime("%A %b %d")
	end

	def format_money(price)
		number_to_currency(price, :unit => "$")
	end

end
