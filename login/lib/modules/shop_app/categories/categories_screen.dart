import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/shared/components/components.dart';
import '../../../models/shop_app_model/cartegories_model.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var categoriesModel = ShopCubit.get(context).categoriesModel;
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildCategoriesItem(categoriesModel.data.items[index]),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: categoriesModel!.data.items.length,
        );
      },
    );
  }

  Widget buildCategoriesItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Image(
              width: 80.0,
              height: 80.0,
              image: NetworkImage(model.image),
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              model.name,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      );
}
