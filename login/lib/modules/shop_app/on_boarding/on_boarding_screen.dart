import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/shared/components/components.dart';
import 'package:login/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/styles/colors.dart';
import '../../basics_app/login/login_screen.dart';
import '../login/shop_login_screen.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatelessWidget {
  var boardController = PageController();
  bool isLast = false;
  List<BoardingModel> items = [
    BoardingModel(
        image: 'assets/images/shopping_app.png',
        title: 'On Board 1 title',
        body: 'On Board 1 body'),
    BoardingModel(
        image: 'assets/images/shopping_app.png',
        title: 'On Board 2 title',
        body: 'On Board 2 body'),
    BoardingModel(
        image: 'assets/images/shopping_app.png',
        title: 'On Board 3 title',
        body: 'On Board 3 body'),
  ];

  OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            onPressed: () {
              submit(context: context);
            },
            text: 'skip',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(items[index]),
                onPageChanged: (index) {
                  if (index == items.length - 1) {
                    isLast = true;
                  } else {
                    isLast = false;
                  }
                },
                itemCount: items.length,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController, // PageController
                    count: items.length,
                    effect: ExpandingDotsEffect(
                        spacing: 5.0,
                        expansionFactor: 4,
                        dotWidth: 10.0,
                        dotHeight: 10.0,
                        dotColor: Colors.grey,
                        activeDotColor: default_color), // your preferred effect
                    onDotClicked: (index) {
                      boardController.jumpToPage(index);
                    }),
                const Spacer(),
                FloatingActionButton(
                  elevation: 0.0,
                  onPressed: () {
                    if (isLast) {
                      submit(context: context);
                    }
                    boardController.nextPage(
                      duration: const Duration(
                        milliseconds: 750,
                      ),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
        ],
      );

  void submit({required context}) {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value!) {
        navigateAndFinish(context: context, widget: ShopLoginScreen());
      }
    });
  }
}
