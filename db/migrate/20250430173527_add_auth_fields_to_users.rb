class AddAuthFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    change_table :users, bulk: true do |t|
      t.string  :password_digest
      t.datetime :last_login_at
      t.datetime :deleted_at
      t.string  :role
    end

    add_index :users, :email, unique: true
    add_index :users, :deleted_at  # ← ソフトデリート用スコープに便利
  end
end