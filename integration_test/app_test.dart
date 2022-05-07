import 'package:f_local_database_shared_prefs_template/domain/repositories/user_repository.dart';
import 'package:f_local_database_shared_prefs_template/domain/use_case/authentication.dart';
import 'package:f_local_database_shared_prefs_template/ui/controllers/authentication_controller.dart';
import 'package:f_local_database_shared_prefs_template/ui/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loggy/loggy.dart';

Future<Widget> createHomeScreen() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(UserRepository());
  Get.lazyPut<Authentication>(() => Authentication());
  Get.put(AuthenticationController());
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );
  return MyApp();
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Complete test", (WidgetTester tester) async {
    Widget w = await createHomeScreen();
    await tester.pumpWidget(w);

    //verify that we are in login page
    expect(find.byKey(const Key('loginScaffold')), findsOneWidget);

    // clear all data
    await tester.tap(find.byKey(const Key('clearAll')));

    await tester.pumpAndSettle();

    // go to sign up
    await tester.tap(find.byKey(const Key('loginCreateUser')));

    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('signUpEmail')), 'a@a.com');

    await tester.enterText(find.byKey(const Key('signUpPassord')), '123456');

    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));

    await tester.tap(find.byKey(const Key('signUpSubmit')));

    await tester.pumpAndSettle();

    //verify that we are in login page
    expect(find.byKey(const Key('loginScaffold')), findsOneWidget);

    // go to sign up
    await tester.tap(find.byKey(const Key('loginCreateUser')));

    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('signUpEmail')), 'b@b.com');

    await tester.enterText(find.byKey(const Key('signUpPassord')), '123456');

    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));

    await tester.tap(find.byKey(const Key('signUpSubmit')));

    await tester.pumpAndSettle();

    //verify that we are in login page
    expect(find.byKey(const Key('loginScaffold')), findsOneWidget);

    var checkbox = tester
        .firstWidget(find.byKey(const Key('storeUserCheckBox'))) as Checkbox;
    expect(checkbox.value, false);

    //login
    await tester.enterText(find.byKey(const Key('loginEmail')), 'a@a.com');

    await tester.enterText(find.byKey(const Key('loginPassord')), '123456');

    await tester.tap(find.byKey(const Key('loginSubmit')));

    await tester.pumpAndSettle();

    //verify that we are in content page
    expect(find.byKey(const Key('contentScaffold')), findsOneWidget);

    // go to profile page
    await tester.tap(find.byIcon(Icons.verified_user));
    await tester.pumpAndSettle();

    // logout
    await tester.tap(find.byKey(const Key('profileLogout')));
    await tester.pumpAndSettle();

    //verify that we are in login page
    expect(find.byKey(const Key('loginScaffold')), findsOneWidget);

    checkbox = tester.firstWidget(find.byKey(const Key('storeUserCheckBox')))
        as Checkbox;
    expect(checkbox.value, false);

    //login
    await tester.enterText(find.byKey(const Key('loginEmail')), 'b@b.com');

    await tester.enterText(find.byKey(const Key('loginPassord')), '123456');

    await tester.tap(find.byKey(const Key('loginSubmit')));

    await tester.pumpAndSettle();

    //verify that we are in content page
    expect(find.byKey(const Key('contentScaffold')), findsOneWidget);

    // go to profile page
    await tester.tap(find.byIcon(Icons.verified_user));
    await tester.pumpAndSettle();

    // logout
    await tester.tap(find.byKey(const Key('profileLogout')));
    await tester.pumpAndSettle();

    //verify that we are in login page
    expect(find.byKey(const Key('loginScaffold')), findsOneWidget);

    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));

    //login that should fail
    await tester.enterText(find.byKey(const Key('loginEmail')), 'c@c.com');

    await tester.enterText(find.byKey(const Key('loginPassord')), '123456');

    await tester.tap(find.byKey(const Key('loginSubmit')));

    await tester.pumpAndSettle();

    //verify that we are in login page
    expect(find.byKey(const Key('loginScaffold')), findsOneWidget);

    ///////// check box to store user
    expect(find.byKey(const Key('storeUserCheckBox')), findsOneWidget);

    await tester.tap(find.byKey(const Key('storeUserCheckBox')));

    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));

    checkbox = tester.firstWidget(find.byKey(const Key('storeUserCheckBox')))
        as Checkbox;
    expect(checkbox.value, true);

    //login
    await tester.enterText(find.byKey(const Key('loginEmail')), 'a@a.com');

    await tester.enterText(find.byKey(const Key('loginPassord')), '123456');

    await tester.tap(find.byKey(const Key('loginSubmit')));

    await tester.pumpAndSettle();

    //verify that we are in content page
    expect(find.byKey(const Key('contentScaffold')), findsOneWidget);

    // go to profile page
    await tester.tap(find.byIcon(Icons.verified_user));
    await tester.pumpAndSettle();

    // logout
    await tester.tap(find.byKey(const Key('profileLogout')));
    await tester.pumpAndSettle();

    //verify that we are in login page
    expect(find.byKey(const Key('loginScaffold')), findsOneWidget);

    // now we login without entering info (should be stored)

    await tester.pump(const Duration(seconds: 5));

    expect(find.text('a@a.com'), findsOneWidget);
    await tester.tap(find.byKey(const Key('loginSubmit')));

    await tester.pumpAndSettle();

    //verify that we are in content page
    expect(find.byKey(const Key('contentScaffold')), findsOneWidget);

    // go to profile page
    await tester.tap(find.byIcon(Icons.verified_user));
    await tester.pumpAndSettle();

    // logout
    await tester.tap(find.byKey(const Key('profileLogout')));
    await tester.pumpAndSettle();

    //verify that we are in login page
    expect(find.byKey(const Key('loginScaffold')), findsOneWidget);
  });
}
