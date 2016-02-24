# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160224064905) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "image"
    t.string   "title"
    t.string   "author"
    t.integer  "page"
    t.text     "content"
    t.text     "comment"
    t.boolean  "is_cover",        default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "issue_column_id"
  end

  create_table "articles_keywords", force: :cascade do |t|
    t.integer "article_id", null: false
    t.integer "keyword_id", null: false
  end

  add_index "articles_keywords", ["article_id", "keyword_id"], name: "articles_keywords_index", unique: true, using: :btree

  create_table "carriers", force: :cascade do |t|
    t.string "name"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "collectors", force: :cascade do |t|
    t.string "name"
  end

  create_table "columns", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "issue_columns", force: :cascade do |t|
    t.integer "magazine_id",             null: false
    t.integer "column_id",               null: false
    t.integer "page",        default: 0
  end

  add_index "issue_columns", ["magazine_id", "column_id"], name: "issue_columns_index", unique: true, using: :btree

  create_table "issues", force: :cascade do |t|
    t.string "name"
  end

  create_table "keywords", force: :cascade do |t|
    t.string "name"
  end

  add_index "keywords", ["name"], name: "index_keywords_on_name", unique: true, using: :btree

  create_table "keywords_records", force: :cascade do |t|
    t.integer "keyword_id"
    t.integer "record_id"
  end

  add_index "keywords_records", ["keyword_id", "record_id"], name: "index_keywords_records_on_keyword_id_and_record_id", unique: true, using: :btree

  create_table "languages", force: :cascade do |t|
    t.string "name"
  end

  create_table "magazines", force: :cascade do |t|
    t.string   "name"
    t.string   "volumn"
    t.string   "image"
    t.integer  "issue"
    t.string   "pdf"
    t.string   "google_play"
    t.date     "published_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "patterns", force: :cascade do |t|
    t.string "name"
  end

  create_table "records", force: :cascade do |t|
    t.string  "identifier"
    t.integer "category_id"
    t.integer "carrier_id"
    t.integer "pattern_id"
    t.integer "issue_id"
    t.integer "language_id"
    t.integer "collector_id"
    t.boolean "sensitive",    default: false
    t.string  "title"
    t.string  "contributor"
    t.string  "publisher"
    t.date    "date"
    t.string  "unit"
    t.string  "size"
    t.string  "page"
    t.integer "quantity"
    t.text    "catalog"
    t.text    "content"
    t.string  "information"
    t.text    "comment"
    t.string  "copyright"
    t.string  "right_in_rem"
    t.string  "ownership"
    t.boolean "published",    default: true
    t.string  "licence"
    t.string  "filename"
    t.string  "filetype"
    t.string  "creator"
    t.date    "created_at"
    t.string  "commentor"
    t.date    "commented_at"
    t.string  "updater"
    t.date    "updated_at"
    t.string  "image"
    t.integer "visits",       default: 0,     null: false
    t.integer "statistics",   default: 0,     null: false
    t.string  "serial_no"
  end

  add_index "records", ["identifier"], name: "index_records_on_identifier", unique: true, using: :btree

  create_table "records_subjects", force: :cascade do |t|
    t.integer "record_id",  null: false
    t.integer "subject_id", null: false
  end

  add_index "records_subjects", ["record_id", "subject_id"], name: "records_subjects_index", unique: true, using: :btree

  create_table "subjects", force: :cascade do |t|
    t.string  "name"
    t.string  "icon"
    t.integer "order"
  end

end
