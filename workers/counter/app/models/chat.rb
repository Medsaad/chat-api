class Chat < ApplicationRecord
    belongs_to :application
    has_many :messages
  
    validates :number, presence: true

    def self.count_messages
        @chats = self.all
        @chats.each do |chat|
            puts "updating chat ##{chat.number}"
            chat.messages_count = chat.messages.count
            chat.save
        end
    end
end