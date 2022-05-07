import 'package:loggy/loggy.dart';

import '../../../domain/entities/random_user.dart';
import '../../utils/local_preferences.dart';

class UserLocalSharedPrefs {
  late LocalPreferences _sharedPreferences;

  UserLocalSharedPrefs() {
    _sharedPreferences = LocalPreferences();
  }
  Future<void> storeUserInfo(User user) async {
    logInfo(
        'UserLocalSharedPrefs storeUserInfo ${user.email} ${user.password}');
    await _sharedPreferences.storeData<bool>('storedUser', true);
    await _sharedPreferences.storeData<String>('email', user.email);
    await _sharedPreferences.storeData<String>('password', user.password);
    return Future.value();
  }

  Future<User> getUserInfo() async {
    logInfo('UserLocalSharedPrefs getUserInfo');
    bool storedUser =
        await _sharedPreferences.retrieveData<bool>('storedUser') ?? false;
    logInfo('UserLocalSharedPrefs getUserInfo storedUser? <$storedUser>');
    if (storedUser) {
      var savedUser =
          await _sharedPreferences.retrieveData<String>('email') ?? "";
      var savedPassword =
          await _sharedPreferences.retrieveData<String>('password') ?? "";
      logInfo('UserLocalSharedPrefs getUserInfo <$savedUser< <$savedPassword>');
      return Future.value(User(email: savedUser, password: savedPassword));
    } else {
      logError('UserLocalSharedPrefs getUserInfo no user');
      return Future.error("No user");
    }
  }

  Future<void> clearUserInfo() async {
    logInfo('UserLocalSharedPrefs clearUserInfo');
    await _sharedPreferences.storeData<String>('email', "");
    await _sharedPreferences.storeData<String>('password', "");
    return _sharedPreferences.storeData<bool>('storedUser', false);
  }

  Future<bool> init() async =>
      await _sharedPreferences.retrieveData<bool>('logged') ?? false;

  logout() async {
    logInfo('UserLocalSharedPrefs logout');
    await _sharedPreferences.storeData<bool>('logged', false);
  }

  deleteAll() async {
    await _sharedPreferences.deleteAll();
  }

  Future<bool> isStoringUser() async =>
      await _sharedPreferences.retrieveData<bool>('storedUser') ?? false;
}
