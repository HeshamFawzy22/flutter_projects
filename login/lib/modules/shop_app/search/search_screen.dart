import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/modules/shop_app/search/cubit/cubit.dart';
import 'package:login/modules/shop_app/search/cubit/states.dart';
import 'package:login/shared/components/components.dart';

import '../cubit/cubit.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit, ShopSearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    defaultTextForm(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      text: 'Search',
                      prefix: Icons.search,
                      validator: (value) {
                        if (value == null) {
                          return ('Enter text to search');
                        }
                        return null;
                      },
                      onsubmit: (text) {
                        ShopSearchCubit.get(context).getSearchData(text: text);
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    if (state is ShopSearchLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    if (state is ShopSearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => buildShopItem(
                                ShopSearchCubit.get(context)
                                    .searchModel
                                    .data
                                    .data[index],
                                context,
                                isOldPrice: false),
                            separatorBuilder: (context, index) => myDivider(),
                            itemCount: ShopSearchCubit.get(context)
                                .searchModel
                                .data
                                .data
                                .length),
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
