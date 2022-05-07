import 'package:loggy/loggy.dart';
import '../../data/datasources/local/user_local_datasource_sqflite.dart';
import '../../data/datasources/local/user_local_shared_prefs.dart';
import '../entities/random_user.dart';

// here we call the corresponding local source
class UserRepository {
  late UserLocalDataSource localDataSource;
  late UserLocalSharedPrefs userLocalSharedPrefs;

  UserRepository() {
    logInfo("Starting UserRepository");
    localDataSource = UserLocalDataSource();
    userLocalSharedPrefs = UserLocalSharedPrefs();
  }

  Future<void> addUser(User user) async {}

  Future<List<User>> getAllUsers() async => await localDataSource.getAllUsers();

  Future<void> storeUserInfo(User user) async {}

  Future<User> getStoredUser() async {
    try {
      return await userLocalSharedPrefs.getUserInfo();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> clearStoredUser() async {}

  init() async => await userLocalSharedPrefs.init();

  signup(User user) async {}

  logout() async {}

  clearAll() async {
    await localDataSource.deleteAll();
    await userLocalSharedPrefs.deleteAll();
  }

  Future<bool> isStoringUser() async {}
}
