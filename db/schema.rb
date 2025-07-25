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

ActiveRecord::Schema.define(version: 2016_07_27_084117) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", id: :serial, force: :cascade do |t|
    t.string "image"
    t.string "title"
    t.string "author"
    t.integer "page"
    t.text "content"
    t.text "comment"
    t.boolean "is_cover", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "issue_column_id"
    t.date "published_at"
  end

  create_table "articles_keywords", id: :serial, force: :cascade do |t|
    t.integer "article_id", null: false
    t.integer "keyword_id", null: false
    t.index ["article_id", "keyword_id"], name: "articles_keywords_index", unique: true
  end

  create_table "carriers", id: :serial, force: :cascade do |t|
    t.string "name"
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name"
  end

  create_table "collectors", id: :serial, force: :cascade do |t|
    t.string "name"
  end

  create_table "columns", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "issue_columns", id: :serial, force: :cascade do |t|
    t.integer "magazine_id", null: false
    t.integer "column_id", null: false
    t.integer "page", default: 0
    t.string "name"
    t.index ["magazine_id", "column_id"], name: "issue_columns_index", unique: true
  end

  create_table "issues", id: :serial, force: :cascade do |t|
    t.string "name"
  end

  create_table "keywords", id: :serial, force: :cascade do |t|
    t.string "name"
    t.index ["name"], name: "index_keywords_on_name", unique: true
  end

  create_table "keywords_records", id: :serial, force: :cascade do |t|
    t.integer "keyword_id"
    t.integer "record_id"
    t.index ["keyword_id", "record_id"], name: "index_keywords_records_on_keyword_id_and_record_id", unique: true
  end

  create_table "languages", id: :serial, force: :cascade do |t|
    t.string "name"
  end

  create_table "magazines", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "volumn"
    t.string "image"
    t.integer "issue"
    t.string "pdf"
    t.string "google_play"
    t.date "published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "patterns", id: :serial, force: :cascade do |t|
    t.string "name"
  end

  create_table "records", id: :serial, force: :cascade do |t|
    t.string "identifier"
    t.integer "category_id"
    t.integer "carrier_id"
    t.integer "pattern_id"
    t.integer "issue_id"
    t.integer "language_id"
    t.integer "collector_id"
    t.boolean "sensitive", default: false
    t.string "title"
    t.string "contributor"
    t.string "publisher"
    t.date "date"
    t.string "unit"
    t.string "size"
    t.string "page"
    t.integer "quantity"
    t.text "catalog"
    t.text "content"
    t.string "information"
    t.text "comment"
    t.string "copyright"
    t.string "right_in_rem"
    t.string "ownership"
    t.boolean "published", default: true
    t.string "license"
    t.string "filename"
    t.string "filetype"
    t.string "creator"
    t.date "created_at"
    t.string "commentor"
    t.date "commented_at"
    t.string "updater"
    t.date "updated_at"
    t.string "image"
    t.integer "visits", default: 0, null: false
    t.integer "statistics", default: 0, null: false
    t.string "serial_no"
    t.string "pdf"
    t.string "slug"
    t.index ["identifier"], name: "index_records_on_identifier", unique: true
    t.index ["slug"], name: "index_records_on_slug", unique: true
  end

  create_table "records_subjects", id: :serial, force: :cascade do |t|
    t.integer "record_id", null: false
    t.integer "subject_id", null: false
    t.index ["record_id", "subject_id"], name: "records_subjects_index", unique: true
  end

  create_table "redactor_assets", id: :serial, force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.integer "assetable_id"
    t.string "assetable_type", limit: 30
    t.string "type", limit: 30
    t.integer "width"
    t.integer "height"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["assetable_type", "assetable_id"], name: "idx_redactor_assetable"
    t.index ["assetable_type", "type", "assetable_id"], name: "idx_redactor_assetable_type"
  end

  create_table "subjects", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "icon"
    t.integer "order"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", default: "", null: false
    t.boolean "admin", default: false, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "provider"
    t.string "provider_uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
