class AddIndexes < ActiveRecord::Migration[5.2]
  def change
    add_index :chats, :number
    add_index :messages, :number
    add_index :messages, :body, :length => 50
  end
end
