json.array! @applications do |application|
  json.name application.name
  json.token application.access_token
  json.chats application.chats_count
end