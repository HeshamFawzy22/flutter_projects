import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:login/layout/social_app/cubit/cubit.dart';
import 'package:login/layout/social_app/cubit/states.dart';
import 'package:login/modules/social_app/new_post/new_post_screen.dart';
import 'package:login/modules/social_app/notifications/notification_screen.dart';
import 'package:login/modules/social_app/search/SearchScreen.dart';
import 'package:login/shared/components/components.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostState) {
          navigateTo(context: context, widget: NewPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: SocialCubit.get(context).currentIndex != 4
              ? AppBar(
                  actions: [
                    IconButton(
                        onPressed: () {
                          navigateTo(
                              context: context,
                              widget: const NotificationScreen());
                        },
                        icon: const Icon(
                          IconBroken.Notification,
                          size: 20.0,
                        )),
                    IconButton(
                        onPressed: () {
                          navigateTo(
                              context: context, widget: const SearchScreen());
                        },
                        icon: const Icon(
                          IconBroken.Search,
                          size: 20.0,
                        ))
                  ],
                  title: Text(
                    cubit.titles[cubit.currentIndex],
                  ),
                )
              : null,
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: SizedBox(
            height: 50.0,
            child: BottomNavigationBar(
              selectedFontSize: 10.0,
              unselectedFontSize: 8.0,
              currentIndex: cubit.currentIndex,
              items: cubit.items,
              showSelectedLabels: false,
              // Hide labels for selected items
              showUnselectedLabels: false,
              // Hide labels for unselected items
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
            ),
          ),
        );
      },
    );
  }
}
