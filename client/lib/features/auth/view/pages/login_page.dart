import 'dart:developer';

import 'package:client/core/utils.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/features/auth/view/widgets/auth_button.dart';
import 'package:client/core/widgets/generic_text_field.dart';
import 'package:client/features/auth/view/widgets/navigation_text.dart';
import 'package:client/features/auth/view/widgets/var_text.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final formKey;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authViewmodelProvider)?.isLoading == true;
    ref.listen(authViewmodelProvider, (prev, next) {
      next?.when(
        data: (data) {
          //Todo: Navigate to home page
        },
        error: (error, st) {
          showSnackBar(context, error.toString());
        },
        loading: () {},
      );
    });

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
                    VarText(text: "Login", size: 30),
                    VarText(text: "To your vibes", size: 50),
                    SizedBox(height: 30),
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
                              .loginUser(
                                email: _email.text,
                                password: _password.text,
                              );
                        }
                      },
                      label: "Login",
                    ),
                    SizedBox(height: 18),
                    NavigationText(
                      label1: "Don't have an account? ",
                      label2: "Sign Up",
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
