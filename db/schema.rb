# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170506213712) do

  create_table "challenges", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "opponent_id"
    t.string   "type"
    t.decimal  "wager_amount", precision: 8, scale: 2
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["opponent_id"], name: "index_challenges_on_opponent_id"
    t.index ["team_id"], name: "index_challenges_on_team_id"
  end

  create_table "colorations", force: :cascade do |t|
    t.integer  "tournament_id"
    t.integer  "color_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["color_id"], name: "index_colorations_on_color_id"
    t.index ["tournament_id"], name: "index_colorations_on_tournament_id"
  end

  create_table "colors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enrollments", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "tournament_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "organizer"
    t.integer  "user_id"
    t.index ["team_id"], name: "index_enrollments_on_team_id"
    t.index ["tournament_id"], name: "index_enrollments_on_tournament_id"
    t.index ["user_id"], name: "index_enrollments_on_user_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "captain"
    t.index ["team_id"], name: "index_memberships_on_team_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "sports", force: :cascade do |t|
    t.string   "name"
    t.string   "sport_image"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "tournament_id"
    t.integer  "size"
    t.integer  "color_id"
    t.index ["color_id"], name: "index_teams_on_color_id"
    t.index ["name"], name: "index_teams_on_name"
    t.index ["tournament_id"], name: "index_teams_on_tournament_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string   "name"
    t.integer  "capacity"
    t.integer  "venue_id"
    t.integer  "sport_id"
    t.datetime "date"
    t.decimal  "bet_amount",   precision: 8, scale: 2
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "organizer_id"
    t.integer  "team_size"
    t.time     "time"
    t.string   "hash_id"
    t.date     "eowd_date"
    t.index ["organizer_id"], name: "index_tournaments_on_organizer_id"
    t.index ["sport_id"], name: "index_tournaments_on_sport_id"
    t.index ["venue_id"], name: "index_tournaments_on_venue_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "profile_image"
    t.string   "full_name"
    t.string   "hash_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "venues", force: :cascade do |t|
    t.string   "name"
    t.string   "venue_image"
    t.string   "address"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
