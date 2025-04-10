class RoomModel {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;
  List<Messages>? messages;
  List<Users>? users;

  RoomModel(
      {this.id,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.pivot,
      this.messages,
      this.users});

  RoomModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(Messages.fromJson(v));
      });
    }
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pivot {
  int? usersId;
  int? roomsId;

  Pivot({this.usersId, this.roomsId});

  Pivot.fromJson(Map<String, dynamic> json) {
    usersId = json['users_id'];
    roomsId = json['rooms_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['users_id'] = usersId;
    data['rooms_id'] = roomsId;
    return data;
  }
}

class Messages {
  int? id;
  String? text;
  String? state;
  int? senderUsersId;
  int? resiverUsersId;
  int? roomId;
  String? createdAt;
  String? updatedAt;

  Messages(
      {this.id,
      this.text,
      this.state,
      this.senderUsersId,
      this.resiverUsersId,
      this.roomId,
      this.createdAt,
      this.updatedAt});

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    state = json['state'];
    senderUsersId = json['sender_users_id'];
    resiverUsersId = json['resiver_users_id'];
    roomId = json['room_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return data;
  }
}

class Users {
  int? id;
  String? name;
  String? email;
  String? password;
  String? city;
  String? image;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Users(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.city,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    city = json['city'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['city'] = city;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}
