class CreateUsers < ActiveRecord::Migration[6.1]

  def change
    create_table :users do |t|
      t.string   :name
      t.string   :email, null: false
      t.string   :password_digest, null: false
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      t.timestamps

      t.index :email, unique: true
    end
  end

end
