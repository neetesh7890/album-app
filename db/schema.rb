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

ActiveRecord::Schema.define(version: 20170810091332) do

  create_table "album_images", force: :cascade do |t|
    t.integer "album_id"
    t.string "image_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_album_images_on_album_id"
  end

  create_table "albums", force: :cascade do |t|
    t.integer "user_id"
    t.string "album_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "comment_count"
    t.index ["user_id"], name: "index_albums_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "commentable_type"
    t.integer "commentable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "comment_name"
    t.integer "user_id"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "user_details", force: :cascade do |t|
    t.text "address"
    t.string "city"
    t.integer "pincode"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "phone", limit: 8
    t.index ["user_id"], name: "index_user_details_on_user_id"
  end

  create_table "user_friends", force: :cascade do |t|
    t.integer "user_id"
    t.integer "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.string "status"
    t.index ["user_id"], name: "index_user_friends_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.string "password"
    t.string "gender"
    t.date "dob"
    t.string "avater"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "status_email"
    t.boolean "remember_me"
    t.integer "count"
  end

end
