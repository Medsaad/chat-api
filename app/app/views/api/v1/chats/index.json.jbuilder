json.array! @chats do |chat|
  json.number chat.number
  json.message_count chat.messages_count
end