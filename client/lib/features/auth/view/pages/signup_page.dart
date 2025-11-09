import 'dart:developer';

import 'package:client/features/auth/repository/auth_remote_repository.dart';
import 'package:client/features/auth/view/widgets/auth_button.dart';
import 'package:client/features/auth/view/widgets/generic_text_field.dart';
import 'package:client/features/auth/view/widgets/navigation_text.dart';
import 'package:client/features/auth/view/widgets/var_text.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' as fp;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
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
                  final response = await AuthRemoteRepository().signup(
                    name: _name.text,
                    password: _password.text,
                    email: _email.text,
                  );
                  final val = switch (response) {
                    fp.Left(value: final l) => l,
                    fp.Right(value: final r) => r,
                  };
                  log(val.toString());
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
