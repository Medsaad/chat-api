class MessageJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @application = Application.where(access_token: args[1]).first
    @chat = @application.chats.where(number: args[2]).first
    
    case args[0]
    when 'create'
      message_number = @chat.messages.count + 1
      @message = Message.new(number: message_number, body: args[3]['body'], chat: @chat)
      @message.save
    when 'update'
      @message = Message.where(number: args[3]).where(chat: @chat).first
      @message.update(args[4])
    end
  end
end
