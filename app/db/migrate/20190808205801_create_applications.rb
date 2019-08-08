class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :access_token
      t.integer :chats_count, default: 0

      t.timestamps
    end
    add_index :applications, :access_token, unique: true
  end
end
