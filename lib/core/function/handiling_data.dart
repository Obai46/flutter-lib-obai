import '../class/status_request.dart';

handilingData(response) {
  if (response is StatusRequest) {
    return response;
  } else {
    return StatusRequest.succes;
  }
}
