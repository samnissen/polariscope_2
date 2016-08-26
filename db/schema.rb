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

ActiveRecord::Schema.define(version: 20160826125214) do

  create_table "action_statuses", force: true do |t|
    t.integer  "run_test_action_id"
    t.integer  "browser_type_id"
    t.boolean  "success"
    t.string   "notes"
    t.text     "log",                limit: 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "api_id"
    t.text     "screenshot",         limit: 2147483647
  end

  add_index "action_statuses", ["api_id"], name: "index_action_statuses_on_api_id", unique: true, using: :btree
  add_index "action_statuses", ["browser_type_id"], name: "index_action_statuses_on_browser_type_id", using: :btree
  add_index "action_statuses", ["run_test_action_id"], name: "index_action_statuses_on_run_test_action_id", using: :btree
  add_index "action_statuses", ["user_id"], name: "index_action_statuses_on_user_id", using: :btree

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "activities", force: true do |t|
    t.string   "action_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "grouping"
    t.boolean  "object_required"
    t.boolean  "data_required"
    t.string   "description"
    t.boolean  "archived",        default: false
  end

  create_table "admin_users", force: true do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "browser_types", force: true do |t|
    t.string   "name"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "archived",   default: false
  end

  create_table "collections", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "collections", ["user_id"], name: "index_collections_on_user_id", using: :btree

  create_table "data_element_values", force: true do |t|
    t.string   "encrypted_value"
    t.integer  "environment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "data_element_id"
    t.integer  "user_id"
    t.boolean  "random_value",        default: false
    t.integer  "random_value_length", default: 8
  end

  add_index "data_element_values", ["data_element_id"], name: "index_data_element_values_on_data_element_id", using: :btree
  add_index "data_element_values", ["environment_id"], name: "index_data_element_values_on_environment_id", using: :btree
  add_index "data_element_values", ["user_id"], name: "index_data_element_values_on_user_id", using: :btree

  create_table "data_elements", force: true do |t|
    t.string   "key"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  add_index "data_elements", ["user_id"], name: "index_data_elements_on_user_id", using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "did_you_mean_types", force: true do |t|
    t.string   "description"
    t.string   "key"
    t.boolean  "archived"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "did_you_means", force: true do |t|
    t.integer  "action_status_id"
    t.string   "possibility"
    t.integer  "did_you_mean_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "did_you_means", ["action_status_id"], name: "index_did_you_means_on_action_status_id", using: :btree
  add_index "did_you_means", ["did_you_mean_type_id"], name: "index_did_you_means_on_did_you_mean_type_id", using: :btree

  create_table "environments", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "environments", ["user_id"], name: "index_environments_on_user_id", using: :btree

  create_table "java_script_event_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "archived",   default: false
  end

  create_table "object_identifier_siblings", force: true do |t|
    t.string   "identifier"
    t.integer  "object_type_id"
    t.integer  "selector_id"
    t.integer  "object_identifier_id"
    t.integer  "sibling_relationship_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  add_index "object_identifier_siblings", ["object_identifier_id"], name: "index_object_identifier_siblings_on_object_identifier_id", using: :btree
  add_index "object_identifier_siblings", ["sibling_relationship_id"], name: "index_object_identifier_siblings_on_sibling_relationship_id", using: :btree
  add_index "object_identifier_siblings", ["user_id"], name: "index_object_identifier_siblings_on_user_id", using: :btree

  create_table "object_identifiers", force: true do |t|
    t.string   "identifier"
    t.integer  "object_type_id"
    t.integer  "selector_id"
    t.integer  "test_action_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  add_index "object_identifiers", ["test_action_id"], name: "index_object_identifiers_on_test_action_id", using: :btree
  add_index "object_identifiers", ["user_id"], name: "index_object_identifiers_on_user_id", using: :btree

  create_table "object_types", force: true do |t|
    t.string   "type_name"
    t.string   "html"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "archived",   default: false
  end

  create_table "run_object_identifier_siblings", force: true do |t|
    t.string   "identifier"
    t.integer  "sibling_relationship_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "object_identifier_sibling_id"
    t.integer  "object_type_id"
    t.integer  "selector_id"
    t.integer  "run_object_identifier_id"
  end

  add_index "run_object_identifier_siblings", ["object_identifier_sibling_id"], name: "index_run_oi_siblings_on_oi_sibling_id", using: :btree
  add_index "run_object_identifier_siblings", ["object_type_id"], name: "index_run_object_identifier_siblings_on_object_type_id", using: :btree
  add_index "run_object_identifier_siblings", ["run_object_identifier_id"], name: "index_run_object_identifier_siblings_on_run_object_identifier_id", using: :btree
  add_index "run_object_identifier_siblings", ["selector_id"], name: "index_run_object_identifier_siblings_on_selector_id", using: :btree
  add_index "run_object_identifier_siblings", ["sibling_relationship_id"], name: "index_run_object_identifier_siblings_on_sibling_relationship_id", using: :btree

  create_table "run_object_identifiers", force: true do |t|
    t.string   "identifier"
    t.integer  "run_test_action_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "object_identifier_id"
    t.integer  "object_type_id"
    t.integer  "selector_id"
  end

  add_index "run_object_identifiers", ["object_identifier_id"], name: "index_run_object_identifiers_on_object_identifier_id", using: :btree
  add_index "run_object_identifiers", ["object_type_id"], name: "index_run_object_identifiers_on_object_type_id", using: :btree
  add_index "run_object_identifiers", ["run_test_action_id"], name: "index_run_object_identifiers_on_run_test_action_id", using: :btree
  add_index "run_object_identifiers", ["selector_id"], name: "index_run_object_identifiers_on_selector_id", using: :btree

  create_table "run_test_action_data", force: true do |t|
    t.text     "data"
    t.integer  "run_object_identifier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "test_action_datum_id"
    t.boolean  "encrypted",                default: false
  end

  add_index "run_test_action_data", ["run_object_identifier_id"], name: "index_run_test_action_data_on_run_object_identifier_id", using: :btree
  add_index "run_test_action_data", ["test_action_datum_id"], name: "index_run_test_action_data_on_test_action_datum_id", using: :btree

  create_table "run_test_actions", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "test_action_id"
    t.integer  "activity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "run_test_id"
  end

  add_index "run_test_actions", ["activity_id"], name: "index_run_test_actions_on_activity_id", using: :btree
  add_index "run_test_actions", ["run_test_id"], name: "index_run_test_actions_on_run_test_id", using: :btree
  add_index "run_test_actions", ["test_action_id"], name: "index_run_test_actions_on_test_action_id", using: :btree

  create_table "run_tests", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "user_id"
    t.integer  "run_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "testset_id"
  end

  add_index "run_tests", ["testset_id"], name: "index_run_tests_on_testset_id", using: :btree

  create_table "runs", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "collection_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "environment_id"
    t.boolean  "ready_to_send",     default: false
    t.boolean  "sent",              default: false
    t.string   "test_ids"
    t.string   "browsers"
    t.integer  "scheduled_test_id"
    t.integer  "user_id"
  end

  add_index "runs", ["collection_id"], name: "index_runs_on_collection_id", using: :btree
  add_index "runs", ["environment_id"], name: "index_runs_on_environment_id", using: :btree
  add_index "runs", ["scheduled_test_id"], name: "index_runs_on_scheduled_test_id", using: :btree
  add_index "runs", ["user_id"], name: "index_runs_on_user_id", using: :btree

  create_table "scheduled_tests", force: true do |t|
    t.text     "notes"
    t.integer  "collection_id"
    t.string   "test_ids"
    t.datetime "next_test"
    t.integer  "recurring"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "browser_ids"
    t.integer  "environment_id"
  end

  add_index "scheduled_tests", ["collection_id"], name: "index_scheduled_tests_on_collection_id", using: :btree
  add_index "scheduled_tests", ["environment_id"], name: "index_scheduled_tests_on_environment_id", using: :btree
  add_index "scheduled_tests", ["user_id"], name: "index_scheduled_tests_on_user_id", using: :btree

  create_table "selectors", force: true do |t|
    t.string   "selector_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "archived",      default: false
  end

  create_table "sibling_relationships", force: true do |t|
    t.string   "relation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "archived",   default: false
  end

  create_table "test_action_data", force: true do |t|
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "data_element_id"
    t.integer  "object_identifier_id"
    t.integer  "position"
  end

  add_index "test_action_data", ["data_element_id"], name: "index_test_action_data_on_data_element_id", using: :btree
  add_index "test_action_data", ["object_identifier_id"], name: "index_test_action_data_on_object_identifier_id", using: :btree

  create_table "test_actions", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "testset_id"
    t.integer  "activity_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.integer  "pointer"
  end

  add_index "test_actions", ["activity_id"], name: "index_test_actions_on_activity_id", using: :btree
  add_index "test_actions", ["testset_id"], name: "index_test_actions_on_testset_id", using: :btree
  add_index "test_actions", ["user_id"], name: "index_test_actions_on_user_id", using: :btree

  create_table "test_statuses", force: true do |t|
    t.integer  "run_test_id"
    t.integer  "browser_type_id"
    t.boolean  "success"
    t.string   "notes"
    t.text     "log",             limit: 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "api_id"
  end

  add_index "test_statuses", ["api_id"], name: "index_test_statuses_on_api_id", unique: true, using: :btree
  add_index "test_statuses", ["browser_type_id"], name: "index_test_statuses_on_browser_type_id", using: :btree
  add_index "test_statuses", ["run_test_id"], name: "index_test_statuses_on_run_test_id", using: :btree
  add_index "test_statuses", ["user_id"], name: "index_test_statuses_on_user_id", using: :btree

  create_table "testsets", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "collection_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "testsets", ["collection_id"], name: "index_testsets_on_collection_id", using: :btree
  add_index "testsets", ["user_id"], name: "index_testsets_on_user_id", using: :btree

  create_table "users", force: true do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
