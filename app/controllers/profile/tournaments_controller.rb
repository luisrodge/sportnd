class Profile::TournamentsController < ApplicationController
	before_action :authenticate_user!

	def index
	end

	def show
		@tournament = Tournament.find(params[:id])
	end

	def new
	end

	def create
		tournament = Tournament.new(tournament_params)
		date_format = "%m/%d/%Y %I:%M %p"
      	date = DateTime.strptime(params[:tournament][:date], date_format).change(offset: Time.now.strftime("%z")).to_s
		tournament.date = date
		tournament.organizer = current_user
		if tournament.save
			redirect_to profile_tournaments_path
		end
	end

	private

	def tournament_params
		params.require(:tournament).permit(:name, :capacity, :team_size, :bet_amount, :sport_id, :venue_id, :date, :organizer_id)
	end
end
