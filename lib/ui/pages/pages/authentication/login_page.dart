import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import '../../../controllers/authentication_controller.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  AuthenticationController controller = Get.find<AuthenticationController>();

  updateStoreUser(val) {
    controller.storeUser = val;
  }

  getStoreUser() async {
    await controller.getStoredUser();
    _emailController.text = controller.storeUserEmail;
    _passwordController.text = controller.storeUserPassword;
  }

  clearStoreUser() async {
    await controller.clearStoredUser();
  }

  clearAll() async {
    await controller.clearAll();
  }

  @override
  void initState() {
    getStoreUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.storeUser == false) {
      _emailController.clear();
      _passwordController.clear();
    }
    return Scaffold(
      key: const Key('loginScaffold'),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(
                    () => Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const Text(
                            "Login with email",
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            key: const Key('loginEmail'),
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                const InputDecoration(labelText: 'Email'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter email";
                              } else if (!value.contains('@')) {
                                return "Enter valid email address";
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            key: const Key('loginPassord'),
                            controller: _passwordController,
                            decoration:
                                const InputDecoration(labelText: "Password"),
                            keyboardType: TextInputType.number,
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter password";
                              } else if (value.length < 6) {
                                return "Password should have at least 6 characters";
                              }
                              return null;
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text('Store user'),
                              Checkbox(
                                  key: const Key('storeUserCheckBox'),
                                  value: controller.storeUser,
                                  onChanged: updateStoreUser)
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              key: const Key('loginSubmit'),
                              onPressed: () async {
                                // this line dismiss the keyboard by taking away the focus of the TextFormField and giving it to an unused
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                final form = _formKey.currentState;
                                form!.save();
                                if (form.validate()) {
                                  var value = await controller.login(
                                      _emailController.text,
                                      _passwordController.text);
                                  if (value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text('User ok')));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text('User problem')));
                                  }
                                } else {
                                  var snackBar = const SnackBar(
                                    content: Text('Validation nok'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                              child: const Text("Submit")),
                        ],
                      ),
                    ),
                  ),
                ),
                TextButton(
                    key: const Key('loginCreateUser'),
                    onPressed: () {
                      Get.to(() => const SignUpPage());
                    },
                    child: const Text("Create user")),
                TextButton(
                    key: const Key('clearAll'),
                    onPressed: () {
                      clearAll();
                    },
                    child: const Text("Clear all"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
