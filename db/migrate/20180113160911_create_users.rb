class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.timestamps

      t.text :email, null: false
      t.text :password_digest, null: false
      t.text :name, null: false
      t.jsonb :data, null: false, default: {}
    end

    add_index(:users, :created_at)
    add_index(:users, :email)
    add_index(:users, :name)
  end
end
