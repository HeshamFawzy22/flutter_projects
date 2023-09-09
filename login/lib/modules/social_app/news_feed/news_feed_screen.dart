import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:login/layout/social_app/cubit/cubit.dart';
import 'package:login/layout/social_app/cubit/states.dart';
import 'package:login/models/social_app/post_model.dart';
import 'package:login/shared/styles/colors.dart';

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.isNotEmpty &&
              SocialCubit.get(context).userModel != null,
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5.0,
                  margin: const EdgeInsets.all(10.0),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      const Image(
                        image: NetworkImage(
                            'https://img.freepik.com/free-photo/social-media-marketing-concept-marketing-with-applications_23-2150063128.jpg?w=900&t=st=1691582912~exp=1691583512~hmac=151385254508296711039c956f93a4414e88ad6ab8be85b628571cf1c34978c8'),
                        fit: BoxFit.cover,
                        height: 220.0,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text('Chat with your friends',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPostItem(
                      SocialCubit.get(context).posts[index], context, index),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 8.0,
                  ),
                  itemCount: SocialCubit.get(context).posts.length,
                ),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget buildPostItem(PostModel model, context, index) => Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(
                    model.image,
                  ),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          model.name,
                          style: TextStyle(
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: default_color,
                          size: 14.0,
                        )
                      ],
                    ),
                    Text(
                      model.dateTime,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            height: 1.4,
                          ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.more_horiz,
                    size: 18.0,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 5.0, bottom: 10.0),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            // Until recently, the prevailing view assumed lorem ipsum was'
            // ' born as a nonsense text. “It\'s not Latin, though it'
            //     ' looks like it, and it actually says nothing,” Before &'
            //     ' After magazine answered a curious reader, “Its ‘words’'
            //     ' loosely approximate the frequency with which letters '
            //     'occur in English, which is why at a glance it looks'
            //     ' pretty real.”
            Text(
              model.text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            // Padding(
            //   padding: const EdgeInsetsDirectional.only(bottom: 10.0, top: 5.0),
            //   child: SizedBox(
            //     width: double.infinity,
            //     child: Wrap(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(end: 5.0),
            //           child: SizedBox(
            //             height: 20.0,
            //             child: MaterialButton(
            //               padding: EdgeInsets.zero,
            //               minWidth: 1.0,
            //               child: Text(
            //                 '#software_development',
            //                 style:
            //                     Theme.of(context).textTheme.bodySmall?.copyWith(
            //                           color: default_color,
            //                         ),
            //               ),
            //               onPressed: () {},
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(end: 5.0),
            //           child: SizedBox(
            //             height: 20.0,
            //             child: MaterialButton(
            //               padding: EdgeInsets.zero,
            //               minWidth: 1.0,
            //               child: Text(
            //                 '#flutter',
            //                 style:
            //                     Theme.of(context).textTheme.bodySmall?.copyWith(
            //                           color: default_color,
            //                         ),
            //               ),
            //               onPressed: () {},
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            if (model.postImage != '')
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 10.0),
                child: Container(
                  height: 160.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    image: DecorationImage(
                      // https://img.freepik.com/free-photo/portrait-excited-businessman-dressed-suit_171337-150.jpg?w=996&t=st=1691592269~exp=1691592869~hmac=e92bd65549ce9dd88fab355b23b8440591ee40e3522469ffbe047c25660e2583
                      image: NetworkImage(model.postImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          const Icon(
                            IconBroken.Heart,
                            color: Colors.red,
                            size: 16.0,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '${SocialCubit.get(context).likes[index]}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Chat,
                            color: Colors.amber,
                            size: 16.0,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '0',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          Text(
                            'comment',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 10.0),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 15.0,
                          backgroundImage: NetworkImage(
                            // https://img.freepik.com/free-photo/portrait-happy-male-with-broad-smile_176532-8175.jpg?w=996&t=st=1691588819~exp=1691589419~hmac=578530fad761ac7d625f6352761c1e663aefee5f2641a80dbcf257c1b4fcb507
                            '${SocialCubit.get(context).userModel?.image}',
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'write a comment ...',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
                InkWell(
                  onTap: () {
                    SocialCubit.get(context)
                        .likePost(SocialCubit.get(context).postsId[index]);
                  },
                  child: Row(
                    children: [
                      const Icon(
                        IconBroken.Heart,
                        color: Colors.red,
                        size: 16.0,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
