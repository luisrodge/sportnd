class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :memberships, dependent: :destroy
  has_many :teams, through: :memberships

  has_many :started_tournaments, foreign_key: "organizer_id", class_name: 'Tournament'

  has_many :enrollments, dependent: :destroy
  has_many :tournaments, through: :enrollments

  mount_uploader :profile_image, ProfileImageUploader

end
