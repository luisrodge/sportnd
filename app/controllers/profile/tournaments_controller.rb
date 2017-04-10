class Profile::TournamentsController < ApplicationController
	before_action :authenticate_user!

	def index
	end

	def show
		@tournament = Tournament.find(params[:id])
	end

	# New tournament
	# New tournament team
	def new
		@tournament = Tournament.new
		@tournament.teams.build
	end

	# Create a new tournament
	# Enroll organizer with a new team in tournament
	# Associate organizer in saved tournament
	def create
		@tournament = Tournament.new(tournament_params)
		date_format = "%m/%d/%Y %I:%M %p"
  	#date = DateTime.strptime(params[:tournament][:date], date_format).change(offset: Time.now.strftime("%z")).to_s
		#@tournament.date = date
		@tournament.organizer = current_user
		if @tournament.valid?
			@tournament.save
			team = @tournament.teams.new(color_id: params[:tournament][:teams_attributes]["0"][:color])
			team.captain = current_user
			team.save
			@tournament.users << current_user
			redirect_to tournament_path(@tournament)
		else
			@tournament.teams.build if @tournament.teams.blank?
  		render :action => 'new'
		end
	end

	# Cancel or destroy a tournament
	def destroy
		Tournament.find(params[:id]).destroy
		redirect_to profile_tournaments_path
	end

	private

	def tournament_params
		params.require(:tournament).permit(:name, :capacity, :team_size, :bet_amount,
			:sport_id, :venue_id, :date, :time, :organizer_id)
	end
end
