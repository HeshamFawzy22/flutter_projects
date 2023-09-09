import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/shared/components/components.dart';
import 'package:login/shared/components/constants.dart';
import '../../../models/shop_app_model/login_model.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        UserData user = ShopCubit.get(context).loginModel!.data;
        nameController.text = user.name;
        emailController.text = user.email;
        phoneController.text = user.phone;
        return SingleChildScrollView(
          child: ConditionalBuilder(
            condition: ShopCubit.get(context).loginModel != null,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is ShopUpdateUserDataLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 15.0,
                    ),
                    defaultTextForm(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      label: 'Name',
                      prefix: Icons.person,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultTextForm(
                      controller: emailController,
                      keyboardType: TextInputType.text,
                      label: 'Email',
                      prefix: Icons.email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'email must not be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultTextForm(
                      controller: phoneController,
                      keyboardType: TextInputType.text,
                      label: 'Phone',
                      prefix: Icons.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'phone must not be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            ShopCubit.get(context).updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text);
                          }
                        },
                        text: 'Update'),
                    const SizedBox(
                      height: 15.0,
                    ),
                    defaultButton(
                        onPressed: () {
                          signOut(context);
                        },
                        text: 'Logout'),
                  ],
                ),
              ),
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
