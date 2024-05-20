import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/auth.dart';

import '../constants/colors.dart';
import '../widgets/email_text_field.dart';
import '../widgets/password_text_field.dart';
import 'home.dart';
import 'loading.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? errorMessage = '';
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    final BuildContext context = this.context;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const LoadingScreen();
      },
    );

    try {
      await Auth().createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Image.asset(
                      'images/cadastro.png',
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(height: 50),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                children: [
                                  const SizedBox(height: 60),
                                  const Text(
                                    'Sign up',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 16.0),
                                        emailTextField(_emailController),
                                        const SizedBox(height: 16.0),
                                        passwordTextField(
                                            _passwordController, 'Password'),
                                        const SizedBox(height: 16.0),
                                        passwordTextField(
                                            _confirmPasswordController,
                                            'Confirm password'),
                                        const SizedBox(height: 16.0),
                                        if (errorMessage != null &&
                                            errorMessage!.isNotEmpty)
                                          Text(
                                            errorMessage!,
                                            style: const TextStyle(
                                                color: Colors.red),
                                          ),
                                        const SizedBox(height: 16.0),
                                        ElevatedButton(
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              if (_passwordController.text ==
                                                  _confirmPasswordController
                                                      .text) {
                                                await createUserWithEmailAndPassword();
                                                if (errorMessage == null) {
                                                  Navigator.pop(context);
                                                }
                                              } else {
                                                setState(() {
                                                  errorMessage =
                                                      'Passwords do not match';
                                                });
                                              }
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            minimumSize: const Size(150, 50),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                          child: const Text(
                                            'Sign up',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                width: double.infinity,
                                color: Colors.white,
                                padding: const EdgeInsets.all(16.0),
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: RichText(
                                      text: const TextSpan(
                                        text: 'Already have an account? ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Login!',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
