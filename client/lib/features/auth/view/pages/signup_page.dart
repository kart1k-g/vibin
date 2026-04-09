
import 'package:client/core/utils.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/auth/view/widgets/auth_button.dart';
import 'package:client/core/widgets/generic_text_field.dart';
import 'package:client/features/auth/view/widgets/navigation_text.dart';
import 'package:client/features/auth/view/widgets/var_text.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  late final TextEditingController _name;
  late final TextEditingController _password;
  late final TextEditingController _email;
  late final formKey;

  @override
  void initState() {
    _name = TextEditingController();
    _password = TextEditingController();
    _email = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _password.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authViewmodelProvider)?.isLoading == true;

    ref.listen(authViewmodelProvider, (prev, next) {
      next?.when(
        data: (data) {
          showSnackBar(context, "Account created successfully! Please login");

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        },
        error: (error, st) {
          showSnackBar(context, error.toString());
        },
        loading: () {},
      );
    });
    // log(val.toString());
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? Loader()
          : Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    VarText(text: "Sign up &", size: 30),
                    VarText(text: "Begin vibing", size: 50),
                    SizedBox(height: 30),
                    GenericTextField(hintText: "Name", controller: _name),
                    SizedBox(height: 12),
                    GenericTextField(hintText: "Email", controller: _email),
                    SizedBox(height: 12),
                    GenericTextField(
                      hintText: "Password",
                      obscureText: true,
                      controller: _password,
                    ),
                    SizedBox(height: 24),
                    AuthButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          ref
                              .read(authViewmodelProvider.notifier)
                              .signupUser(
                                name: _name.text,
                                email: _email.text,
                                password: _password.text,
                              );
                        }
                      },
                      label: "Sign Up",
                    ),
                    SizedBox(height: 18),
                    NavigationText(
                      label1: "Already have an account? ",
                      label2: "Login",
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
