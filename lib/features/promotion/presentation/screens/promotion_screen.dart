import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/core/constants/height.dart';
import 'package:yelpax/core/constants/width.dart';
import 'package:yelpax/features/promotion/presentation/controllers/promotion_controller.dart';
import 'package:yelpax/features/promotion/presentation/widgets/notice_banner.dart';
import 'package:yelpax/features/promotion/presentation/widgets/sliver_appbar.dart';

class PromotionScreen extends StatefulWidget {
  const PromotionScreen({super.key});

  @override
  State<PromotionScreen> createState() => _PromotionScreenState();
}

class _PromotionScreenState extends State<PromotionScreen> {
  @override
  Widget build(BuildContext context) {
    final _controller = Provider.of<PromotionController>(
      context,
      listen: false,
    );
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          controller: _controller.scrollController,
          slivers: [
            buildSliverAppbar(context),
            SliverList(
              delegate: SliverChildListDelegate([
                Consumer<PromotionController>(
                  builder: (context, value, child) {
                    return value.refreshLoading
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: SizedBox(
                                width: 24, // Fixed width
                                height: 24, // Fixed height
                                child: CircularProgressIndicator.adaptive(
                                  strokeWidth: 3, // Thinner stroke
                                ),
                              ),
                            ),
                          )
                        : SizedBox.shrink();
                  },
                ),
                Container(
                  width: width(context) / 1.2,
                  height: height(context) / 15,
                  child: PageView.builder(
                    scrollBehavior: ScrollBehavior(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return buildNoticeBanner(context);
                    },
                  ),
                ),
                Consumer<PromotionController>(
                  builder: (context, value, child) {
                    if (value.categoryLoading) {
                      return CircularProgressIndicator.adaptive();
                    }
                    if (value.categories.isEmpty) {
                      return InkWell(
                        child: Icon(Icons.refresh),
                        onTap: () => value.getCategories(),
                      );
                    }
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      width: width(context),
                      height: height(context) / 8,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _controller.categories.length,

                        itemBuilder: (context, index) {
                          return _buildCategory(
                            context,
                            value.categories,
                            () {
                              value.openCategory(
                                value.categories[index],
                                context,
                              );
                            },
                            index,
                            'assets/images/y_logo.png',
                          );
                        },
                      ),
                    );
                  },
                ),
                ...List.generate(5, (index) {
                  return Container(
                    width: 100,
                    height: 500,
                    color: Colors.amber,
                    margin: const EdgeInsets.all(10),
                  );
                }),
              ]),
            ),
          ],
          physics: BouncingScrollPhysics(),
        ),
      ),
    );
  }
}

//static widgets
Widget _buildCategory(
  BuildContext context,
  List categories,
  VoidCallback onPress,
  int index,
  String imageUrl,
) {
  return Card(
    child: Column(
      children: [
        InkWell(
          onTap: onPress,
          child: Container(
            height: height(context) / 15,
            width: width(context) / 3,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(imageUrl)),
            ),
          ),
        ),
        Text(categories[index]),
      ],
    ),
  );
}
