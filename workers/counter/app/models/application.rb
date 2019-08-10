class Application < ApplicationRecord
    has_many :chats

    def self.count_chats
        @applications = self.all
        @applications.each do |application|
            puts "updating application #{application.name} at #{Time.now}"
            application.chats_count = application.chats.count
            application.save
        end
    end
end