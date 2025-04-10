class MessageModel {
  int? id;
  String? text;
  String? state;
  int? senderUsersId;
  int? resiverUsersId;
  int? roomId;
  String? createdAt;
  String? updatedAt;
  String? userName;
  String? userImage;

  MessageModel(
      {this.id,
      this.text,
      this.state,
      this.senderUsersId,
      this.resiverUsersId,
      this.roomId,
      this.createdAt,
      this.updatedAt,
      this.userName,
      this.userImage});

  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    state = json['state'];
    senderUsersId = json['sender_users_id'];
    resiverUsersId = json['resiver_users_id'];
    roomId = json['room_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userName = json['user_name'];
    userImage = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['state'] = state;
    data['sender_users_id'] = senderUsersId;
    data['resiver_users_id'] = resiverUsersId;
    data['room_id'] = roomId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user_name'] = userName;
    data['user_image'] = userImage;
    return data;
  }
}
