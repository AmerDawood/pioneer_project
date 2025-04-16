import 'package:pioneer_project/screens/auth/intiative-register/intiative_register_screen.dart';

class ApiSettings {
  static const _API_URL = 'http://10.0.2.2:8000/api/';

  //Auth  For User
  static const LOGIN = _API_URL + 'login';
  static const REGISTER = _API_URL + 'register';
  static const RegisterInitiativeOwnerScreen = _API_URL + 'register/initiative-owner';

  
  static const PROFILE = _API_URL + 'profile';
  static const UPDATE_PROFILE = _API_URL + 'profile/update';

  // INITIATIVES
  static const INITIATIVES = _API_URL + 'initiatives';
  static const INITIATIVES_BY_ID = _API_URL + 'initiatives/{id}';
  static const INITIATIVES_JOIN = _API_URL + 'initiatives/{id}/join';
  static const INITIATIVES_LEAVE = _API_URL + 'initiatives/{id}/leave';
  static const INITIATIVES_participants =
      _API_URL + 'initiatives/{id}/participants';

  // HOME

  static const HOME = _API_URL + 'home';
  static const HOME_NEWS = _API_URL + 'home/news';
  static const HOME_ORG = _API_URL + 'home/organizations';

  // NEWS

  static const NEWS = _API_URL + 'news';
  static const NEWS_BY_ID = _API_URL + 'news/{id}';

  // ORGANIZATION
    static const ORGANIZATIONS = _API_URL + 'organizations';
  static const ORGANIZATIONS_BY_ID = _API_URL + 'organizations/{id}';

  // CONTACT US

  static const CONTACT = _API_URL + 'contact';

  // CONTACT FOR ADMINS
  static const CONTACT_FOR_ADMINS = _API_URL + 'contact-messages';
  static const CONTACT_FOR_ADMINS_BY_ID = _API_URL + 'contact-messages/{id}';

  static const NOTIFICATIONS = _API_URL + 'notifications';
  static const NOTIFICATIONS_BY_ID = _API_URL + 'notifications/{id}';
  static const NOTIFICATIONS_READ = _API_URL + 'notifications/{id}/read';
  static const NOTIFICATIONS_DESTROY = _API_URL + 'notifications/{id}';
}
