import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/layout/social_app/cubit/states.dart';
import 'package:login/models/social_app/post_model.dart';
import 'package:login/models/social_app/social_user_model.dart';
import 'package:login/modules/social_app/chats/chat_screen.dart';
import 'package:login/modules/social_app/new_post/new_post_screen.dart';
import 'package:login/modules/social_app/news_feed/news_feed_screen.dart';
import 'package:login/modules/social_app/settings/settings_screen.dart';
import 'package:login/modules/social_app/users/users_screen.dart';
import 'package:login/shared/components/constants.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;
  var currentIndex = 0;

  List<Widget> screens = [
    NewsFeedScreen(),
    ChatScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'News Feed',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      icon: Icon(IconBroken.Home, size: 20.0),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(IconBroken.Chat, size: 20.0),
      label: 'Chats',
    ),
    const BottomNavigationBarItem(
      icon: Icon(IconBroken.Upload, size: 20.0),
      label: 'Post',
    ),
    const BottomNavigationBarItem(
      icon: Icon(IconBroken.User, size: 20.0),
      label: 'Users',
    ),
    const BottomNavigationBarItem(
      icon: Icon(IconBroken.Setting, size: 20.0),
      label: 'Settings',
    ),
  ];

  void changeBottomNav(index) {
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  void getUserData() {
    emit(SocialInitialState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = SocialUserModel.fromJson(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error));
    });
  }

  XFile? profileImage;
  final ImagePicker picker = ImagePicker();

  Future<void> pickProfileImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = XFile(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  XFile? coverImage;

  Future<void> pickCoverImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = XFile(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  // String profileImageUrl = '';

  void uploadProfileImage({required name, required phone, required bio}) {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(File(profileImage!.path))
        .then((value) => {
              value.ref.getDownloadURL().then((value) {
                updateUser(name: name, phone: phone, bio: bio, profile: value);
                // profileImageUrl = value;
                emit(SocialUploadProfileImageSuccessState());
              }).catchError((error) {
                emit(SocialUploadProfileImageErrorState());
              })
            })
        .catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  // String coverImageUrl = '';

  void uploadCoverImage({required name, required phone, required bio}) {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(File(coverImage!.path))
        .then((value) => {
              value.ref.getDownloadURL().then((value) {
                updateUser(name: name, phone: phone, bio: bio, cover: value);
                // coverImageUrl = value;
                emit(SocialUploadCoverImageSuccessState());
              }).catchError((error) {
                emit(SocialUploadCoverImageErrorState());
              })
            })
        .catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUser(
      {required name, required phone, required bio, profile, cover}) {
    emit(SocialUpdateUserLoadingState());
    // if (profileImage != null) {
    //   uploadProfileImage();
    // } else if (coverImage != null) {
    //   uploadCoverImage();
    // } else {
    SocialUserModel model = SocialUserModel(
      userModel!.uId,
      name,
      userModel!.email,
      phone,
      profile ?? userModel!.image,
      cover ?? userModel!.cover,
      bio,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) => getUserData())
        .catchError((error) {
      emit(SocialUpdateUserErrorState());
    });
    // }
  }

  XFile? postImage;

  Future<void> pickPostImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = XFile(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage() async {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void createPostWithImage({required String dateTime, required String text}) {
    emit(SocialCreatePostLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(File(postImage!.path))
        .then((value) => {
              value.ref.getDownloadURL().then((value) {
                createPost(dateTime: dateTime, text: text, postImage: value);
                emit(SocialCreatePostSuccessState());
              }).catchError((error) {
                emit(SocialCreatePostErrorState());
              })
            })
        .catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({required String dateTime, required String text, postImage}) {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
      userModel!.uId,
      userModel!.name,
      userModel!.image,
      dateTime,
      text,
      postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      //getUserData();
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  void getPosts() {
    emit(SocialGetPostLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((post) {
        post.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(post.id);
          posts.add(PostModel.fromJson(post.data()));
        }).catchError((error) {});
      });
      emit(SocialGetPostSuccessState());
    }).catchError((error) {
      emit(SocialGetPostErrorState(error));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'like': true})
        .then((value) => emit(SocialLikePostSuccessState()))
        .catchError((error) {
          emit(SocialLikePostErrorState(error.toString()));
        });
  }
}
