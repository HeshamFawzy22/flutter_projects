import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialRegisterScreen extends StatelessWidget {
  SocialRegisterScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialRegisterSuccessState) {
            // if (state.loginModel.status) {
            //   CacheHelper.saveData(
            //           key: 'token', value: state.loginModel.data.token)
            //       .then((value) {
            //     token = state.loginModel.data.token;
            //     if (value!) {
            //       navigateAndFinish(
            //           context: context, widget: const SocialLayout());
            //     }
            //   });
            // }
          } else if (state is SocialRegisterErrorState) {
            showToast(
              msg: SocialRegisterCubit.get(context).message,
              state: ToastStates.ERROR,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        defaultTextForm(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          text: 'Name',
                          prefix: Icons.person,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name must not by empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15.0),
                        defaultTextForm(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          text: 'Email Address',
                          prefix: Icons.email,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !value.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15.0),
                        defaultTextForm(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          text: 'Password',
                          isPassword:
                              SocialRegisterCubit.get(context).isPassword,
                          prefix: Icons.lock,
                          suffix: SocialRegisterCubit.get(context).suffix,
                          suffixPressed: () {
                            SocialRegisterCubit.get(context).changeVisibility();
                          },
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15.0),
                        defaultTextForm(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          text: 'Phone',
                          prefix: Icons.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Phone must not by empty';
                            }
                            return null;
                          },
                          onsubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              print(emailController.text);
                              print(passwordController.text);
                              // SocialCubit.get(context)
                              //     .changeBottomIndex(index: 0);
                              SocialRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text);
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoadingState,
                          builder: (context) => defaultButton(
                              text: 'REGISTER',
                              radius: 5.0,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  // SocialCubit.get(context)
                                  //     .changeBottomIndex(index: 0);
                                  SocialRegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text);
                                }
                              }),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
