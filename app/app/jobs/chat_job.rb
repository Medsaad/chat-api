class ChatJob < ApplicationJob
  queue_as :default

  def perform(*args)
    case args[0]
    when 'create'
      @application = Application.where(access_token: args[1]).first
      chat_number = @application.chats.count + 1
      @chat = Chat.new(number: chat_number, application: @application)
      @chat.save

    when 'update'
      #later
    end
  end
end
