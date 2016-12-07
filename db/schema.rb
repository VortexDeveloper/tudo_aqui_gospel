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


ActiveRecord::Schema.define(version: 20161207124408) do


  create_table "ad_plans", force: :cascade do |t|
    t.string   "comercial"
    t.string   "name"
    t.integer  "days"
    t.integer  "value"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "plan_type"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "administrators", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_administrators_on_user_id"
  end

  create_table "ads", force: :cascade do |t|
    t.string   "description"
    t.string   "title"
    t.string   "link"
    t.string   "text_description"
    t.date     "start_date"
    t.date     "end_date"
    t.date     "record_date"
    t.integer  "price"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "category_id"
    t.integer  "announcer_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "ad_type"
    t.string   "home"
    t.integer  "active"
    t.index ["announcer_id"], name: "index_ads_on_announcer_id"
    t.index ["category_id"], name: "index_ads_on_category_id"
  end

  create_table "announcers", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "name"
    t.string   "fantasy_name"
    t.string   "contact_name"
    t.integer  "doc_type"
    t.string   "doc"
    t.string   "email"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "ad_plan_id"
    t.string   "about_text"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
    t.index ["ad_plan_id"], name: "index_announcers_on_ad_plan_id"
    t.index ["user_id"], name: "index_announcers_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "father_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["father_id"], name: "index_categories_on_father_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.integer  "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "columnist_knowledges", force: :cascade do |t|
    t.integer  "columnist_id"
    t.integer  "knowledge_area_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["columnist_id"], name: "index_columnist_knowledges_on_columnist_id"
    t.index ["knowledge_area_id"], name: "index_columnist_knowledges_on_knowledge_area_id"
  end

  create_table "columnist_titles", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "columnists", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "periodicity"
    t.string   "admin_info"
    t.date     "birth_date"
    t.string   "sex"
    t.string   "admin_validate"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "columnist_title_id"
    t.index ["columnist_title_id"], name: "index_columnists_on_columnist_title_id"
    t.index ["user_id"], name: "index_columnists_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "company"
    t.string   "phone"
    t.string   "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "galleries", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "announcer_id"
    t.index ["announcer_id"], name: "index_galleries_on_announcer_id"
  end

  create_table "insiders", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_insiders_on_user_id"
  end

  create_table "knowledge_areas", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "personal_profiles", force: :cascade do |t|
    t.string   "name"
    t.string   "street"
    t.string   "complement"
    t.string   "neighborhood"
    t.integer  "city_id"
    t.integer  "state_id"
    t.integer  "country_id"
    t.string   "zip_code"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
    t.index ["city_id"], name: "index_personal_profiles_on_city_id"
    t.index ["country_id"], name: "index_personal_profiles_on_country_id"
    t.index ["state_id"], name: "index_personal_profiles_on_state_id"
    t.index ["user_id"], name: "index_personal_profiles_on_user_id"
  end

  create_table "phonebooks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "telephone_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["telephone_id"], name: "index_phonebooks_on_telephone_id"
    t.index ["user_id"], name: "index_phonebooks_on_user_id"
  end

  create_table "publications", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.text     "body"
    t.integer  "pub_type",          limit: 1
    t.integer  "pub_category"
    t.integer  "knowledge_area_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "author_id"
    t.index ["author_id"], name: "index_publications_on_author_id"
    t.index ["knowledge_area_id"], name: "index_publications_on_knowledge_area_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.string   "uf"
    t.integer  "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_states_on_country_id"
  end

  create_table "subscribers", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "christian"
    t.string   "church"
    t.date     "birth_date"
    t.string   "sex"
    t.string   "christian_denomination"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["user_id"], name: "index_subscribers_on_user_id"
  end

  create_table "telephones", force: :cascade do |t|
    t.string   "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "active",                 default: 0,  null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

  create_table "vacancies", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "active"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "announcer_id"
    t.index ["announcer_id"], name: "index_vacancies_on_announcer_id"
  end

  create_table "versicles", force: :cascade do |t|
    t.string   "testament"
    t.string   "book"
    t.string   "chapter"
    t.string   "versicle"
    t.string   "text"
    t.date     "show_day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
