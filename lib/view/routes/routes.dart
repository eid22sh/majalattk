import 'package:get/get.dart';
import 'package:majalatek/view/screens/SpecialityProvidersScreen/speciality_providers_screen.dart';

import '../screens/BeforeLoginScreen/before_login_screen.dart';
import '../screens/ChatScreen/chat_screen.dart';
import '../screens/ContinueRegisterScreen/continue_register_screen.dart';
import '../screens/ConverstaionScreen/conversations_screen.dart';
import '../screens/DeparmentsScreen/departments_screen.dart';
import '../screens/DepartmentsSepcialitiesScreen/departments_specialities_screen.dart';
import '../screens/EditContactsScreen/edit_contact_screen.dart';
import '../screens/EditImages/edit_images_screen.dart';
import '../screens/HomeScreen/home_screen.dart';
import '../screens/PhoneScreen/phone_screen.dart';
import '../screens/RateProviderScreen/rate_provider_screen.dart';
import '../screens/RegisterScreen/register_screen.dart';
import '../screens/SearchProvidersScreen/search_providers_screen.dart';
import '../screens/SearchResultScreen/search_result_screen.dart';
import '../screens/SpecialProfileScreen/special_profile_screen.dart';
import '../screens/SplashScreen/splash_screen.dart';
import '../screens/UpdateScreen/update_screen.dart';
import '../screens/VerifyPhoneScreen/verfiy_phone_screen.dart';
import '../screens/WelcomingScreens/lang_screen.dart';
import '../screens/WelcomingScreens/welcome_screen1.dart';

List<GetPage> routes = [
  GetPage(
      name: WelcomeScreen1.id,
      page: () => WelcomeScreen1(),
      transition: Transition.noTransition),
  GetPage(
      name: LangScreen.id,
      page: () => LangScreen(),
      transition: Transition.noTransition),
  GetPage(
      name: HomeScreen.id,
      page: () => HomeScreen(),
      transition: Transition.noTransition),
  GetPage(
      name: SplashScreen.id,
      page: () => SplashScreen(),
      transition: Transition.noTransition),
  GetPage(
      name: ProfileScreen.id,
      page: () => ProfileScreen(),
      transition: Transition.noTransition),
  GetPage(
    name: SearchProviderScreen.id,
    page: () => SearchProviderScreen(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: SearchResultScreen.id,
    page: () => SearchResultScreen(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: RateProviderScreen.id,
    page: () => RateProviderScreen(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: ChatScreen.id,
    page: () => ChatScreen(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: BeforeLoginScreen.id,
    page: () => BeforeLoginScreen(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: PhoneScreen.id,
    page: () => PhoneScreen(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: VerifyPhoneScreen.id,
    page: () => VerifyPhoneScreen(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: RegisterScreen.id,
    page: () => RegisterScreen(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: ContinueRegistration.id,
    page: () => ContinueRegistration(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: UpdateScreen.id,
    page: () => UpdateScreen(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: EditContactsScreen.id,
    page: () => EditContactsScreen(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: EditImageScreen.id,
    page: () => EditImageScreen(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: DepartmentsProvidersScreen.id,
    page: () => DepartmentsProvidersScreen(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: ConversationScreen.id,
    page: () => ConversationScreen(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: DepSpecScreen.id,
    page: () => DepSpecScreen(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: SpecProvidersScreen.id,
    page: () => SpecProvidersScreen(),
    transition: Transition.noTransition,
  )
];
