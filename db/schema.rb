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

ActiveRecord::Schema.define(version: 20151012205532) do

  create_table "api_keys", force: :cascade do |t|
    t.string   "access_token", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "blacklight_folders_folder_items", force: :cascade do |t|
    t.integer  "folder_id",   limit: 4,     null: false
    t.integer  "bookmark_id", limit: 4,     null: false
    t.integer  "position",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description", limit: 65535
  end

  add_index "blacklight_folders_folder_items", ["bookmark_id"], name: "index_blacklight_folders_folder_items_on_bookmark_id", using: :btree
  add_index "blacklight_folders_folder_items", ["folder_id"], name: "index_blacklight_folders_folder_items_on_folder_id", using: :btree

  create_table "blacklight_folders_folders", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.integer  "user_id",           limit: 4,                 null: false
    t.string   "user_type",         limit: 255,               null: false
    t.string   "visibility",        limit: 255
    t.integer  "number_of_members", limit: 4,     default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description",       limit: 65535
  end

  add_index "blacklight_folders_folders", ["user_type", "user_id"], name: "index_blacklight_folders_folders_on_user_type_and_user_id", using: :btree

  create_table "bookmarks", force: :cascade do |t|
    t.integer  "user_id",       limit: 4,   null: false
    t.string   "user_type",     limit: 255
    t.string   "document_id",   limit: 255
    t.string   "title",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "document_type", limit: 255
  end

  add_index "bookmarks", ["user_id"], name: "index_bookmarks_on_user_id", using: :btree

  create_table "featured_boards", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "url",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published",  limit: 1
    t.string   "snapshot",   limit: 255
  end

  create_table "featured_contents", force: :cascade do |t|
    t.string   "title",         limit: 255
    t.text     "description",   limit: 65535
    t.boolean  "published",     limit: 1
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "preview_image", limit: 255
    t.string   "url",           limit: 255
  end

  create_table "featured_images", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.string   "record_id",      limit: 255
    t.string   "uploaded_image", limit: 255
    t.boolean  "published",      limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "file_caches", force: :cascade do |t|
    t.string   "record_id",     limit: 255
    t.string   "url",           limit: 255
    t.boolean  "valid_content", limit: 1
    t.string   "content_type",  limit: 255
    t.string   "filepath",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flag_votes", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "flag_id",    limit: 4
    t.integer  "weight",     limit: 4
    t.string   "record_id",  limit: 40
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flag_votes", ["user_id", "flag_id", "record_id"], name: "index_flag_votes_on_user_id_and_flag_id_and_record_id", unique: true, using: :btree

  create_table "flags", force: :cascade do |t|
    t.string   "on_text",                 limit: 255
    t.string   "off_text",                limit: 255
    t.string   "on_text_display",         limit: 255
    t.string   "off_text_display",        limit: 255
    t.integer  "search_filter_threshold", limit: 4
    t.boolean  "restrict_to_editors",     limit: 1
    t.boolean  "published",               limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "on_css",                  limit: 255
    t.string   "off_css",                 limit: 255
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "body",       limit: 65535
    t.string   "link_title", limit: 255
    t.string   "link_path",  limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "slug",       limit: 255
  end

  add_index "pages", ["slug"], name: "index_pages_on_slug", using: :btree

  create_table "records", force: :cascade do |t|
    t.string   "record_hash", limit: 55
    t.text     "metadata",    limit: 4294967295
    t.string   "ingest_name", limit: 255
    t.string   "ingest_hash", limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "records", ["ingest_name"], name: "index_records_on_ingest_name", length: {"ingest_name"=>191}, using: :btree
  add_index "records", ["record_hash"], name: "index_records_on_record_hash", unique: true, using: :btree

  create_table "searches", force: :cascade do |t|
    t.text     "query_params", limit: 16777215
    t.integer  "user_id",      limit: 4
    t.string   "user_type",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "searches", ["user_id"], name: "index_searches_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "",    null: false
    t.string   "encrypted_password",     limit: 255,   default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "guest",                  limit: 1,     default: false
    t.string   "avatar",                 limit: 255
    t.string   "name",                   limit: 255
    t.string   "twitter_handle",         limit: 255
    t.text     "biography",              limit: 65535
    t.integer  "roles_mask",             limit: 4
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  limit: 255,        null: false
    t.integer  "item_id",    limit: 4,          null: false
    t.string   "event",      limit: 255,        null: false
    t.string   "whodunnit",  limit: 255
    t.text     "object",     limit: 4294967295
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
