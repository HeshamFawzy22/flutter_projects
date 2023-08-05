import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/layout/news_app/cubit/cubit.dart';
import 'package:login/layout/news_app/cubit/states.dart';
import 'package:login/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).searchList;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultTextForm(
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  text: 'Search',
                  prefix: Icons.search,
                  onchange: (value) {
                    NewsCubit.get(context).getSearch(value: value);
                  },
                  validator: (value) {
                    if (value == null) {
                      return ('Search can not be null');
                    }
                    return null;
                  },
                ),
              ),
              Expanded(child: articleBuilder(list, context, isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}