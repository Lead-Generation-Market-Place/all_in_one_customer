import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/config/themes/theme_mode_type.dart';
import 'package:yelpax/config/themes/theme_provider.dart';
import 'package:yelpax/core/constants/height.dart';
import 'package:yelpax/core/constants/width.dart';
import 'package:yelpax/features/promotion/presentation/controllers/promotion_controller.dart';
import 'package:yelpax/features/promotion/presentation/widgets/notice_banner.dart';
import 'package:yelpax/shared/widgets/custom_input.dart';
import 'package:yelpax/shared/widgets/custom_shimmer.dart';

class PromotionScreen extends StatefulWidget {
  const PromotionScreen({super.key});

  @override
  State<PromotionScreen> createState() => _PromotionScreenState();
}

class _PromotionScreenState extends State<PromotionScreen> {
  @override
  void initState() {
    _initializeData();
    // TODO: implement initState
    super.initState();
  }

  void _initializeData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final theme = Provider.of<ThemeProvider>(context, listen: false);

      theme.setTheme(ThemeModeType.dark);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _controller = Provider.of<PromotionController>(
      context,
      listen: false,
    );
    TextEditingController _searchController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          surfaceTintColor: Colors.transparent,
          shadowColor: Theme.of(context).primaryColor,
          title: Text('Yelpax'),
          elevation: 2.2,
          actionsPadding: const EdgeInsets.symmetric(horizontal: 8),
          actions: [
            InkWell(child: Icon(Icons.settings_outlined)),
            SizedBox(width: 10),
            InkWell(child: Icon(Icons.notifications_outlined)),
            SizedBox(width: 10),
            InkWell(child: Icon(CupertinoIcons.cart)),
            SizedBox(width: 10),
            InkWell(child: Icon(Icons.question_mark_outlined)),
            SizedBox(width: 10),
            InkWell(child: Icon(CupertinoIcons.heart)),
          ],
        ),
        body: RefreshIndicator.adaptive(
          onRefresh: () => _controller.retry(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CustomInput(
                  hint: 'Search...',
                  icon: Icons.search_outlined,
                  controller: _searchController,
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
                      return CustomShimmer(
                        crossAxisCount: 8,
                        scrollDirection: Axis.horizontal,

                        layoutType: ShimmerLayoutType.horizontalList,
                      );
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
              ],
            ),
          ),
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
