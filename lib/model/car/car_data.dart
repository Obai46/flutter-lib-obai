

import '../../../core/class/crud.dart';
import '../../../link_api.dart';

class CarsData {
  late CRUD crud;
  getdata({required String token}) async {
    var response = await crud.getData(AppLink.carsAll, token);
    return response.fold((l) => l, (r) => r);
  }
}
