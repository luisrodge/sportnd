class Profile::TournamentsController < ApplicationController
	before_action :authenticate_member!
	layout 'full', only: [:new, :create]

	def index
	end

	def show
		@tournament = Tournament.find_by_hash_id!(params[:id])
	end

	# New tournament
	# New tournament team
	def new
		authorize Tournament
		@tournament = Tournament.new
	end

	# Create a new tournament
	# Enroll organizer with a new team in tournament
	# Associate organizer in saved tournament
	def create
		@tournament = Tournament.new(tournament_params)
		@tournament.sport = Sport.last
		@tournament.team_size = 2
		@tournament.bet_amount = 5
		@tournament.capacity = 4
		@tournament.eowd_date = Date.today.next_week.end_of_week - 2
		@tournament.date = @tournament.eowd_date + (params[:tournament][:date].to_i - @tournament.eowd_date.wday)
		@tournament.organizer = current_member
		if @tournament.valid?
			@tournament.save
			team = @tournament.teams.new(color_id: params[:tournament][:team_color_id])
			team.captain = current_member
			team.save
			@tournament.members << current_member
			redirect_to tournament_path(@tournament)
		else
			@tournament.teams.build if @tournament.teams.blank?
  		render :action => 'new'
		end
	end

	# Cancel or destroy a tournament
	def destroy
		@tournament = Tournament.find_by_hash_id(params[:id])
		authorize @tournament
		@tournament.destroy
		redirect_to profile_tournaments_path
	end

	private

	def tournament_params
		params.require(:tournament).permit(:name, :capacity, :team_size, :bet_amount,
			:sport_id, :venue_id, :date, :time, :team_color_id, :week, :eowd_date, :organizer_id, :hash_id)
	end
end
