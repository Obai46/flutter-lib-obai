class CarsModel {
  int? id;
  String? type;
  String? image;
  String? createdAt;
  String? updatedAt;

  CarsModel({this.id, this.type, this.image, this.createdAt, this.updatedAt});

  CarsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
