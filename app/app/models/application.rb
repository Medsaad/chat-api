class Application < ApplicationRecord
  has_many :chats
  has_secure_token :access_token
end
