class CleanupUsers < ActiveRecord::Migration[5.2]
  def up
    drop_table :users
  end

  def down
    create_table "users", id: :serial, force: :cascade do |t|
      t.string "username", null: false
      t.string "email"
      t.string "crypted_password"
      t.string "salt"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "remember_me_token"
      t.datetime "remember_me_token_expires_at"
      t.string "reset_password_token"
      t.datetime "reset_password_token_expires_at"
      t.datetime "reset_password_email_sent_at"
      t.datetime "last_login_at"
      t.datetime "last_logout_at"
      t.datetime "last_activity_at"
      t.integer "failed_logins_count", default: 0
      t.datetime "lock_expires_at"
      t.string "last_login_from_ip_address"
      t.index ["last_logout_at", "last_activity_at"], name: "index_users_on_last_logout_at_and_last_activity_at"
      t.index ["remember_me_token"], name: "index_users_on_remember_me_token"
      t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
    end
  end
end
