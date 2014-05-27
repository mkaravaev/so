json.id @answer.id
json.body @answer.body
json.user_id @answer.user_id

json.attachments @answer.attachments do |attachment|
  json.name attachment.file.identifier
  json.url attachment.file.url
end