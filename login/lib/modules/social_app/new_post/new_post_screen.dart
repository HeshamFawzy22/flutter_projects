import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:login/layout/social_app/cubit/cubit.dart';
import 'package:login/layout/social_app/cubit/states.dart';
import '../../../shared/components/components.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({super.key});

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar:
                defaultAppBar(context: context, title: 'Create Post', actions: [
              defaultTextButton(
                  onPressed: () {
                    var now = DateTime.now();
                    if (SocialCubit.get(context).postImage == null) {
                      SocialCubit.get(context).createPost(
                          dateTime: now.toString(), text: textController.text);
                    } else {
                      SocialCubit.get(context).createPostWithImage(
                          dateTime: now.toString(), text: textController.text);
                    }
                  },
                  text: 'Post'),
            ]),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if (state is SocialCreatePostLoadingState)
                    const LinearProgressIndicator(),
                  if (state is SocialCreatePostLoadingState)
                    const SizedBox(
                      height: 10.0,
                    ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-photo/portrait-happy-male-with-broad-smile_176532-8175.jpg?w=996&t=st=1691588819~exp=1691589419~hmac=578530fad761ac7d625f6352761c1e663aefee5f2641a80dbcf257c1b4fcb507',
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: Text(
                          'Hisham Fawzy',
                          style: TextStyle(
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: textController,
                      decoration: const InputDecoration(
                        hintText: 'What is on your mind, ...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  if (SocialCubit.get(context).postImage != null)
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          height: 160.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            image: DecorationImage(
                              image: FileImage(File(
                                      SocialCubit.get(context).postImage!.path))
                                  as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            SocialCubit.get(context).removePostImage();
                          },
                          icon: const CircleAvatar(
                            radius: 15.0,
                            child: Icon(
                              Icons.close,
                              size: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            SocialCubit.get(context).pickPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconBroken.Image),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'add photo',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            '# tags',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
