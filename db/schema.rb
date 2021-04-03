# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_23_023952) do

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "announcements", force: :cascade do |t|
    t.datetime "published_at"
    t.string "announcement_type"
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string "city_ascii"
    t.string "state_id"
    t.string "state_name"
    t.integer "county_fips"
    t.integer "county_fips_all"
    t.string "county_name_all"
    t.float "lat"
    t.float "lng"
    t.integer "population"
    t.integer "density"
    t.string "source"
    t.boolean "military"
    t.boolean "incorporated"
    t.string "timezone"
    t.integer "ranking"
    t.string "zips"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "school_digger_scan_done", precision: 6, scale: 4, default: "0.0", null: false
  end

  create_table "eateries", force: :cascade do |t|
    t.string "name"
    t.decimal "rating"
    t.integer "no_of_reviews"
    t.string "address"
    t.string "street_one"
    t.string "street_two"
    t.bigint "city_id", null: false
    t.integer "min_wait"
    t.integer "max_wait"
    t.decimal "delivery"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "source_url"
    t.decimal "order_minimum_low"
    t.decimal "order_minimum_high"
    t.text "website"
    t.integer "crm_id"
    t.index ["city_id"], name: "index_eateries_on_city_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "import_cells", force: :cascade do |t|
    t.bigint "import_table_id", null: false
    t.integer "row_index"
    t.integer "column_index"
    t.string "contents"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["import_table_id"], name: "index_import_cells_on_import_table_id"
  end

  create_table "import_tables", force: :cascade do |t|
    t.string "original_path"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "recipient_id"
    t.bigint "actor_id"
    t.datetime "read_at"
    t.string "action"
    t.bigint "notifiable_id"
    t.string "notifiable_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "places", force: :cascade do |t|
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "schools", force: :cascade do |t|
    t.text "schooldigger_link"
    t.string "name"
    t.string "kind"
    t.string "grades"
    t.string "district"
    t.text "schooldigger_district_link"
    t.integer "enrollment"
    t.float "student_teacher_ratio"
    t.float "free_discounted_lunch_recipients"
    t.float "school_digger_rating"
    t.string "schooldigger_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "city_id", null: false
    t.string "street_one"
    t.string "street_two"
    t.index ["city_id"], name: "index_schools_on_city_id"
  end

  create_table "services", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "provider"
    t.string "uid"
    t.string "access_token"
    t.string "access_token_secret"
    t.string "refresh_token"
    t.datetime "expires_at"
    t.text "auth"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_services_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.datetime "announcements_last_read_at"
    t.boolean "admin", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "eateries", "cities"
  add_foreign_key "import_cells", "import_tables"
  add_foreign_key "schools", "cities"
  add_foreign_key "services", "users"
end
