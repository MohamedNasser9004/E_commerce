import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/controllers/login_controller/login_cubit.dart';
import '../../core/controllers/login_controller/login_states.dart';
import '../widgets/botton.dart';
import '../widgets/text_form.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 70),
                    Padding(
                      padding: const EdgeInsets.only(left: 40,right: 40),
                      child: DefaultFieldForm(
                        labelStyle: const TextStyle(color: Colors.black),
                        controller: emailController,
                        keyboard: TextInputType.emailAddress,
                        valid: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter your Email';
                          }
                          return null;
                        },
                        label: 'Email Address',
                        prefix: Icons.email,
                        hint: 'Email Address',
                        hintStyle: const TextStyle(color: Colors.grey),
                        show: false,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, bottom: 50,right: 40),
                      child: DefaultFieldForm(
                        labelStyle: const TextStyle(color: Colors.black),
                        controller: passwordController,
                        keyboard: TextInputType.visiblePassword,
                        valid: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter Your Password';
                          }
                          return null;
                        },
                        label: 'Password',
                        prefix: Icons.password,
                        hint: 'Password',
                        hintStyle: const TextStyle(color: Colors.grey),
                        show: false,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DefaultButton(
                          backgroundColor:Colors.black,
                          borderColor: Colors.transparent,
                          buttonWidget: const Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white),
                          ),
                          function: () {
                            if (formKey.currentState!.validate()) {
                              cubit.userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
