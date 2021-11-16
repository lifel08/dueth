# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_16_195522) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "instrument_id"
    t.bigint "user_id"
    t.datetime "from"
    t.datetime "to"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status"
    t.bigint "receiver_id"
    t.bigint "provider_id"
    t.bigint "disponibility_id"
    t.index ["disponibility_id"], name: "index_bookings_on_disponibility_id"
    t.index ["instrument_id"], name: "index_bookings_on_instrument_id"
    t.index ["provider_id"], name: "index_bookings_on_provider_id"
    t.index ["receiver_id"], name: "index_bookings_on_receiver_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "cancellation_policies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "hours"
  end

  create_table "disponibilities", force: :cascade do |t|
    t.bigint "instrument_id"
    t.datetime "from"
    t.datetime "to"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["instrument_id"], name: "index_disponibilities_on_instrument_id"
  end

  create_table "features", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "icon"
  end

  create_table "instrument_features", force: :cascade do |t|
    t.bigint "feature_id"
    t.bigint "instrument_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["feature_id"], name: "index_instrument_features_on_feature_id"
    t.index ["instrument_id"], name: "index_instrument_features_on_instrument_id"
  end

  create_table "instruments", force: :cascade do |t|
    t.string "title"
    t.string "subtitle"
    t.string "description"
    t.string "location"
    t.decimal "latitude"
    t.decimal "longitude"
    t.bigint "cancellation_policy_id"
    t.integer "price"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "pause", default: false
    t.string "house_number"
    t.string "flat_number"
    t.string "street_name"
    t.string "district"
    t.string "postal_code"
    t.string "city"
    t.string "country"
    t.index ["cancellation_policy_id"], name: "index_instruments_on_cancellation_policy_id"
    t.index ["city"], name: "index_instruments_on_city"
    t.index ["country"], name: "index_instruments_on_country"
    t.index ["district"], name: "index_instruments_on_district"
    t.index ["flat_number"], name: "index_instruments_on_flat_number"
    t.index ["house_number"], name: "index_instruments_on_house_number"
    t.index ["postal_code"], name: "index_instruments_on_postal_code"
    t.index ["street_name"], name: "index_instruments_on_street_name"
    t.index ["user_id"], name: "index_instruments_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.string "content"
    t.bigint "user_id"
    t.bigint "booking_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "instrument_id", null: false
    t.bigint "instrument"
    t.index ["booking_id"], name: "index_reviews_on_booking_id"
    t.index ["instrument_id"], name: "index_reviews_on_instrument_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.datetime "birthday"
    t.string "language", default: "en"
    t.string "description"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["language"], name: "index_users_on_language"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookings", "disponibilities"
  add_foreign_key "instrument_features", "instruments"
  add_foreign_key "instruments", "users"
  add_foreign_key "reviews", "bookings"
  add_foreign_key "reviews", "instruments"
end
