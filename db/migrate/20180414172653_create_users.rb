class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, unique: true
      t.string :token, null: false, index: true, unique: true
      t.string :facebook_id, null: false, index: true, unique: true
      t.string :facebook_access_token, null: false

      t.timestamps
    end
  end
end
