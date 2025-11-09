import 'dart:developer';

import 'package:client/features/auth/repository/auth_remote_repository.dart';
import 'package:client/features/auth/view/widgets/auth_button.dart';
import 'package:client/features/auth/view/widgets/generic_text_field.dart';
import 'package:client/features/auth/view/widgets/navigation_text.dart';
import 'package:client/features/auth/view/widgets/var_text.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' as fp;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
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
                  final response = await AuthRemoteRepository().login(
                    password: _password.text,
                    email: _email.text,
                  );
                  final val=switch(response){
                    fp.Left(value: final l)=> l,
                    fp.Right(value: final r)=> r,
                  };
                  log(val.toString());
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
