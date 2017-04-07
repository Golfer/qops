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

ActiveRecord::Schema.define(version: 20160921090356) do

  create_table "authors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "pseudonym"
    t.string  "full_name"
    t.boolean "publicated",  default: true
    t.string  "description"
    t.date    "burn_date"
    t.date    "die_date"
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name"
    t.string  "ancestry"
      t.boolean "published", default: true
    t.index ["ancestry"], name: "index_categories_on_ancestry", using: :btree
  end

  create_table "categories_quotations", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "quotation_id"
    t.integer "category_id"
    t.index ["category_id"], name: "index_categories_quotations_on_category_id", using: :btree
    t.index ["quotation_id"], name: "index_categories_quotations_on_quotation_id", using: :btree
  end

  create_table "quotations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "author_id"
    t.text     "text",            limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "publicated",                    default: false
    t.datetime "publicated_date"
    t.string   "source"
    t.index ["author_id"], name: "index_quotations_on_author_id", using: :btree
  end

  create_table "quotations_tags", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "quotation_id"
    t.integer "tag_id"
    t.index ["quotation_id"], name: "index_quotations_tags_on_quotation_id", using: :btree
    t.index ["tag_id"], name: "index_quotations_tags_on_tag_id", using: :btree
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
  end

  create_table "roles_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id", null: false
    t.integer "role_id", null: false
    t.index ["role_id"], name: "index_roles_users_on_role_id", using: :btree
    t.index ["user_id", "role_id"], name: "index_roles_users_on_user_id_and_role_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_roles_users_on_user_id", using: :btree
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "tokens", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "username"
    t.string   "uid"
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "expiring",   default: false
    t.datetime "expired_at"
    t.string   "api_token"
    t.string   "api_salt"
    t.index ["api_token"], name: "index_tokens_on_api_token", unique: true, using: :btree
    t.index ["token"], name: "index_tokens_on_token", unique: true, using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "full_name",              default: ""
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
