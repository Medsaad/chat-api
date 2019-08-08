class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :number, null: false
      t.text :body
      t.references :chat, index: true, foreign_key: true

      t.timestamps
    end
  end
end
