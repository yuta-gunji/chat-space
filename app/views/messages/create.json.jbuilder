json.name  @message.user.name
json.date  @message.created_at.strftime("%Y-%m-%d %H:%M:%S")
json.body  @message.body
json.image @message.image_url(:thumb)
