import 'package:get/get.dart';

import 'chat_test/chat/room_chat/rooms_screen.dart';
import 'core/middle_were/my_middle_were.dart';
import 'views/screens/post/add/add_descriptions_screen.dart';
import 'views/screens/authentication/login_screen.dart';
import 'views/screens/authentication/authentication_screen.dart';
import 'views/screens/authentication/register_screen.dart';
import 'views/screens/home/favorite_screen.dart';
import 'views/screens/home/home_bottom_navigation_bar.dart';
import 'views/screens/post/update/edit_descriptions_screen.dart';
import 'views/screens/post/update/edit_post_screen.dart';
import 'views/screens/profile/edit_profile_screen.dart';
import 'views/screens/profile/my_profile_screen.dart';
import 'views/screens/profile/user_pofile_screen.dart';
import 'views/screens/search/filter_screen.dart';
import 'views/screens/settings_page.dart';
import 'views/screens/welcom_screen/welcom_first.dart';

class AppRoutes {
  static const chat = '/chat';
  static const filter = '/filter';
  static const login = '/login';
  static const register = '/register';
  static const authenticationScreen = '/authentication-screen';
  static const home = '/home';
  static const favorite = '/favorite';
  static const addDescreptions = '/add-descriptions';
  static const userProfile = '/user-profile';
  static const myProfile = '/my-profile';
  static const editProfile = '/Editprofile';
  static const settings = '/settings';
  static const editPostScreen = '/edit-post-screen';
  static const editDescriptionsScreen = '/edit-descriptions-screen';

  static final routes = [
    GetPage(
      name: "/",
      page: () => const ConcentricAnimationOnboarding(),
      // page: () => const HomeBottomNavigationBar(),
      // page: () => const HomeScreen(),
      middlewares: [
        MyMiddleWere(),
      ],
    ),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: register, page: () => const RegisterScreen()),
    GetPage(name: authenticationScreen, page: () => AuthenticationScreen()),
    GetPage(name: chat, page: () => const RoomScreen()),
    GetPage(name: home, page: () => const HomeBottomNavigationBar()),
    GetPage(name: favorite, page: () => const FavoriteScreen()),
    GetPage(name: addDescreptions, page: () => const AddDescriptionPage()),
    GetPage(name: myProfile, page: () => const MyProfileScreen()),
    GetPage(name: userProfile, page: () => const UserPofileScreen()),
    GetPage(name: editProfile, page: () => const EditProfileScreen()),
    GetPage(name: settings, page: () => const SettingsScreen()),
    GetPage(name: editPostScreen, page: () => const EditPostScreen()),
    GetPage(name: filter, page: () => const FilterScreen()),
    GetPage(
        name: editDescriptionsScreen,
        page: () => const EditDescriptionsScreen()),
  ];
}
