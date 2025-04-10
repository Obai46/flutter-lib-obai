import '../../../core/class/crud.dart';
import '../../../link_api.dart';

class DescriptionData {
  late CRUD crud;

  getalldescription({required String token}) async {
    var response = await crud.getData(AppLink.allPostWithDescriprtion, token);
    return response.fold((l) => l, (r) => r);
  }

  postaddDescription(
      {required String desCarName,
      required String desModel,
      required String desEngCapacity,
      required String desDisTravel,
      required String desPrice,
      required String desOther,
      required String desCarsid,
      required String desPostsid,
      required String token}) async {
    var response = await crud.postdata(
        AppLink.descriptionsAdd,
        {
          'descriptions_car_name': desCarName,
          'descriptions_model': desModel,
          'descriptions_eng_capacity': desEngCapacity,
          'descriptions_dis_travel': desDisTravel,
          'descriptions_price': desPrice,
          'descriptions_other': desOther,
          'descriptions_carsid': desCarsid,
          'descriptions_postsid': desPostsid,
        },
        token);
    return response.fold((l) => l, (r) => r);
  }
}
