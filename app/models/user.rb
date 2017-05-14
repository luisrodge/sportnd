class User < ApplicationRecord
  #:validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :memberships, dependent: :destroy
  has_many :teams, through: :memberships

  has_many :started_tournaments, foreign_key: "organizer_id", class_name: 'Tournament'

  has_many :enrollments, dependent: :destroy
  has_many :tournaments, through: :enrollments

  # Pagination for infinite scroll feature
  paginates_per 6

  MAX_ENROLLMENTS = 2

  # Devise & Facebook Omniauth
  def self.new_with_session(params, session)
    super.tap do |user|
	    if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
	      user.email = data["email"] if user.email.blank?
	    end
    end
  end

  def self.from_omniauth(auth)
    # Update picture url for existing user if changed in fb
    if user = find_by_uid(auth.uid)
      if auth.info.image.present? && auth.info.image != user.image
        user.update_attributes(image: auth.info.image)
      end
      user
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  	    user.email = auth.info.email
  	    user.password = Devise.friendly_token[0,20]
  	    user.name = auth.info.name   # assuming the user model has a name
  	    user.image = auth.info.image # assuming the user model has an image
  	    user.oauth_token = auth.credentials.token
  	    user.oauth_expires_at = Time.at(auth.credentials.expires_at)

  	    graph = Koala::Facebook::API.new(auth.credentials.token)
  	    user_location = graph.get_object("#{auth.uid}?fields=location")
        if user_location["location"]
  	       user.location = user_location["location"]["name"]
         end
  	  end
    end
  end

  def token_expired?
    return true if expires_at < Time.now
    false
  end

  def update_token(auth)
    self.token = auth.credentials.token
    self.save
  end

  # Koala & Facebook
  def facebook
  	@facebook ||= Koala::Facebook::API.new(oauth_token)
  end

  def friends
    facebook.get_connections("me", "friends", api_version: 'v2.0')
  end

  def is_friend?(user)
    #Koala::Facebook::GraphAPI.new(oauth_access_token).get_connec‌​tions(user1_id, "friends/#{user2_id}").empty?
    facebook.get_connections(uid, "friends/#{user.uid}").present?
  end

  # Future tournaments for a user
  def upcoming_tournaments
    tournaments.where("date >= ? AND time <= ?", Date.today, Time.now).order("date ASC")
  end

  # Check if the user is not enrolled in another tournament with the date matching this new enrollment's
  # Max of two enrollments, one per weekend-day
  def has_tournament_this_date?(tournament)
    tournaments.where(date: tournament.date).exists?
  end

  # Returns a tournament that falls on the same date as another
  def tournament_this_date(tournament)
    tournaments.where(date: tournament.date).first
  end

  # Returns the team a user user is enrolled with for a tournament
  def team_for_tournament(tournament)
    teams.where(tournament_id: tournament).first
  end

  # Checks if a user has already organized a tournament for a given week
  def organized_tournament_this_week?(date)
    tournaments.where(organizer: self).where("Date(date) BETWEEN ? AND ?", date.end_of_week.to_date - 2, date.end_of_week.to_date).exists?
  end

  def tournaments_this_week
    tournaments.where("Date(date) BETWEEN ? AND ?", Date.today.end_of_week - 2, Date.today.end_of_week)
  end

  # Returns true if enrollment limit is reached in a given week for a user
  def enrollment_limit?
    tournaments.where("Date(date) BETWEEN ? AND ?", Date.today.beginning_of_week,
        Date.today.end_of_week).count == MAX_ENROLLMENTS
  end

end
