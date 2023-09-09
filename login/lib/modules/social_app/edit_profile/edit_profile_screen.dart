import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:login/layout/social_app/cubit/cubit.dart';
import 'package:login/layout/social_app/cubit/states.dart';
import 'package:login/shared/components/components.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel!.name;
        bioController.text = userModel.bio;
        phoneController.text = userModel.phone;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              defaultTextButton(
                onPressed: () {
                  SocialCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                },
                text: 'Update',
              ),
              const SizedBox(
                width: 10.0,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialUpdateUserLoadingState)
                    const LinearProgressIndicator(),
                  if (state is SocialUpdateUserLoadingState)
                    const SizedBox(
                      height: 5.0,
                    ),
                  Container(
                    height: 220.0,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                height: 160.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                  ),
                                  image: DecorationImage(
                                    image: coverImage == null
                                        ? NetworkImage(
                                            userModel.cover,
                                          )
                                        : FileImage(File(coverImage.path))
                                            as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).pickCoverImage();
                                },
                                icon: const CircleAvatar(
                                  radius: 15.0,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileImage == null
                                    ? NetworkImage(
                                        userModel.image,
                                      )
                                    : FileImage(File(profileImage.path))
                                        as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                SocialCubit.get(context).pickProfileImage();
                              },
                              icon: const CircleAvatar(
                                radius: 15.0,
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 15.0,
                      left: 20.0,
                      right: 20.0,
                    ),
                    child: Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: defaultButton(
                                      radius: 5.0,
                                      isUberCase: false,
                                      onPressed: () {
                                        SocialCubit.get(context)
                                            .uploadProfileImage(
                                                name: nameController.text,
                                                phone: phoneController.text,
                                                bio: bioController.text);
                                      },
                                      text: 'Upload Photo'),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                    child: defaultButton(
                                        radius: 5.0,
                                        isUberCase: false,
                                        onPressed: () {
                                          SocialCubit.get(context)
                                              .uploadCoverImage(
                                                  name: nameController.text,
                                                  phone: phoneController.text,
                                                  bio: bioController.text);
                                        },
                                        text: 'Upload Cover')),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: 300, // Set the maximum width
                      maxHeight: 60, // Set the maximum height
                    ),
                    child: defaultTextForm(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      label: 'Name',
                      prefix: IconBroken.Profile,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name must not be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: 300, // Set the maximum width
                      maxHeight: 60, // Set the maximum height
                    ),
                    child: defaultTextForm(
                      controller: bioController,
                      keyboardType: TextInputType.text,
                      label: 'Bio',
                      prefix: IconBroken.Info_Circle,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Bio must not be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: 300, // Set the maximum width
                      maxHeight: 60, // Set the maximum height
                    ),
                    child: defaultTextForm(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      label: 'Phone',
                      prefix: IconBroken.Call,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Phone must not be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
