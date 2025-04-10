class FavoriteModel {
  int? id;
  String? title;
  List<String>? imageOut;
  List<String>? imageIn;
  int? usersId;
  String? createdAt;
  String? updatedAt;
  Descriptions? descriptions;
  User? user;

  FavoriteModel(
      {this.id,
      this.title,
      this.imageOut,
      this.imageIn,
      this.usersId,
      this.createdAt,
      this.updatedAt,
      this.descriptions,
      this.user});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageOut = json['image_out'].cast<String>();
    imageIn = json['image_in'].cast<String>();
    usersId = json['users_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    descriptions = json['descriptions'] != null
        ? Descriptions.fromJson(json['descriptions'])
        : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image_out'] = imageOut;
    data['image_in'] = imageIn;
    data['users_id'] = usersId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (descriptions != null) {
      data['descriptions'] = descriptions!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class Descriptions {
  int? id;
  String? name;
  String? model;
  double? price;
  String? typeCar;
  int? carsId;
  int? postsId;
  Cars? cars;

  Descriptions(
      {this.id,
      this.name,
      this.model,
      this.price,
      this.typeCar,
      this.carsId,
      this.postsId,
      this.cars});

  Descriptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    model = json['model'];
    price = json['price'];
    typeCar = json['type_car'];
    carsId = json['cars_id'];
    postsId = json['posts_id'];
    cars = json['cars'] != null ? Cars.fromJson(json['cars']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['model'] = model;
    data['price'] = price;
    data['type_car'] = typeCar;
    data['cars_id'] = carsId;
    data['posts_id'] = postsId;
    if (cars != null) {
      data['cars'] = cars!.toJson();
    }
    return data;
  }
}

class Cars {
  int? id;
  String? type;

  Cars({this.id, this.type});

  Cars.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? password;
  String? city;
  String? image;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.city,
      this.image,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    city = json['city'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return data;
  }
}
