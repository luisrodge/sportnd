class Member < ApplicationRecord
  #:validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :memberships, dependent: :destroy
  has_many :teams, through: :memberships

  has_many :organized_tournaments, foreign_key: "organizer_id", class_name: 'Tournament'

  has_many :enrollments, dependent: :destroy
  has_many :tournaments, through: :enrollments

  # User ElasticSearch and searchkick for searching
  searchkick

  # Pagination for infinite scroll feature
  paginates_per 6

  MAX_ENROLLMENTS = 2

  def search_data
    {
      name: name,
      location: location
    }
  end

  # Devise & Facebook Omniauth
  def self.new_with_session(params, session)
    super.tap do |member|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        member.email = data["email"] if member.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |member|
      member.email = auth.info.email
      member.password = Devise.friendly_token[0,20]
      member.name = auth.info.name
      member.image = auth.info.image
      member.oauth_token = auth.credentials.token
      member.oauth_expires_at = Time.at(auth.credentials.expires_at)

      graph = Koala::Facebook::API.new(auth.credentials.token)
      member_location = graph.get_object("#{auth.uid}?fields=location")
      if member_location["location"]
         member.location = member_location["location"]["name"]
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

  def organized_for_upcoming_week?
    tournaments.where(organizer: self).where("Date(date) BETWEEN ? AND ?", Date.today.next_week.end_of_week - 2, Date.today.next_week.end_of_week).present?
  end

  def upcoming_tournaments
    tournaments.where("date >= ? AND time <= ?", Date.today, Time.now).order("date ASC")
  end

  def has_tournament_this_date?(tournament)
    tournaments.where(date: tournament.date).exists?
  end

  def tournament_this_date(tournament)
    tournaments.where(date: tournament.date).first
  end

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
