import '../car/car_model.dart';

class DescriptionsModel {
  int? id;
  String? name;
  String? model;
  String? engCapacity;
  String? disTravel;
  double? price;
  String? typeCar;
  String? fuelConsumption;
  String? driveSystem;
  int? numberSeats;
  bool? cruiseControlSystem;
  int? carsId;
  int? postsId;
  String? createdAt;
  String? updatedAt;
  CarsModel? carsModel;

  DescriptionsModel(
      {this.id,
      this.name,
      this.model,
      this.engCapacity,
      this.disTravel,
      this.price,
      this.typeCar,
      this.fuelConsumption,
      this.driveSystem,
      this.numberSeats,
      this.cruiseControlSystem,
      this.carsId,
      this.postsId,
      this.createdAt,
      this.updatedAt,
      this.carsModel});

  DescriptionsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    model = json['model'];
    engCapacity = json['eng_capacity'];
    disTravel = json['dis_travel'];
    price = (json['price']).toDouble();
    typeCar = json['type_car'];
    fuelConsumption = json['fuel_consumption'];
    driveSystem = json['drive_system'];
    numberSeats = (json['number_Seats']);
    cruiseControlSystem = json['cruise_control_system'];
    carsId = json['cars_id'];
    postsId = json['posts_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    carsModel = json['cars'] != null ? CarsModel.fromJson(json['cars']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['model'] = model;
    data['eng_capacity'] = engCapacity;
    data['dis_travel'] = disTravel;
    data['price'] = price;
    data['type_car'] = typeCar;
    data['fuel_consumption'] = fuelConsumption;
    data['drive_system'] = driveSystem;
    data['number_Seats'] = numberSeats;
    data['cruise_control_system'] = cruiseControlSystem;
    data['cars_id'] = carsId;
    data['posts_id'] = postsId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (carsModel != null) {
      data['cars'] = carsModel!.toJson();
    }
    return data;
  }
}

// class Cars {
//   int? id;
//   String? type;
//   String? image;
//   String? createdAt;
//   String? updatedAt;

//   Cars({this.id, this.type, this.image, this.createdAt, this.updatedAt});

//   Cars.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     type = json['type'];
//     image = json['image'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['type'] = type;
//     data['image'] = image;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }
