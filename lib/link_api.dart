class AppLink {
  // ======================== Server ========================
  static const String server = "http://192.168.0.103:8000";
  // http://192.168.0.104:8000/api/auth/login
  static const String allposts = "  http://192.168.0.103:8000/alls-post";
  static const String imageApi = "$server/storage";
  static const String api = "$server/api";
  // http://192.168.1.10:8000

  // ======================== Auth ========================
  static const String auth = "$api/auth";
  static const String register = "$auth/register";
  static const String login = "$auth/login";
  static const String userProfile = "$auth/user-profile";
  static const String userInformations = "$auth/user-informations";
  static const String myProfile = "$auth/my-profile";
  static const String updateName = "$auth/update-name";
  static const String updateCity = "$auth/update-city";
  static const String updateImage = "$auth/update-image";
  static const String updatePassword = "$auth/update-password";
  static const String validatePassword = "$auth/validate-password";
  static const String refresh = "$auth/refresh";
  static const String logout = "$auth/logout";

  // ======================== Cars ========================
  static const String cars = "$api/cars";
  static const String carsAll = "$cars/all";
  static const String carsAdd = "$cars/add";
  static const String carsDelete = "$cars/delete";
  static const String carsUpdate = "$cars/update";
  static const String carsOne = "$cars/one";
  // ======================== Posts ========================
  static const String posts = "$api/posts";
  static const String postsAll = "$posts/all";
  static const String allPostWithDescriprtion = "$posts/all-post";
  static const String postsAddWithDescription = "$posts/add-post";
  static const String postsUpdateWithDescription = "$posts/update-post";
  static const String postsAdd = "$posts/add";
  static const String postsDelete = "$posts/delete";
  static const String postsUpdate = "$posts/update";
  static const String postsOne = "$posts/one-post";
  static const String postsSearch = "$posts/search";

  // ======================== posts-saved ========================
  static const String postsSaved = "$api/posts-saved";
  static const String postsSavedAll = "$postsSaved/all";
  static const String postsSavedAdd = "$postsSaved/add";
  static const String postsSavedDelete = "$postsSaved/delete";
  static const String postsSavedUpdate = "$postsSaved/update";
  static const String postsSavedOne = "$postsSaved/one";

  // ======================== descriptions ========================
  static const String descriptions = "$api/descriptions";
  static const String descriptionsAll = "$descriptions/all";
  static const String descriptionsAdd = "$descriptions/add";
  static const String descriptionsDelete = "$descriptions/delete";
  static const String descriptionsUpdate = "$descriptions/update";
  static const String descriptionsOne = "$descriptions/one";

  // ======================== Messages ========================
  static const String messages = "$api/messages";
  static const String messagesAll = "$messages/all";
  static const String messagesAdd = "$messages/add";
  static const String messagesDelete = "$messages/delete";
  static const String messagesUpdate = "$messages/update";
  static const String messagesOne = "$messages/one";

  // ======================== room ========================
  static const String room = "$api/room";
  static const String roomAll = "$room/all";
  static const String roomAdd = "$room/add";
  static const String roomDelete = "$room/delete";
  static const String roomUpdate = "$room/update";
  static const String roomOne = "$room/one";
}
