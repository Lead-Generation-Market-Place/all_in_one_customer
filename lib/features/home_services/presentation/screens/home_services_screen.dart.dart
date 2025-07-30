import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/config/themes/theme_mode_type.dart';
import 'package:yelpax/config/themes/theme_provider.dart';
import 'package:yelpax/features/home_services/presentation/controllers/home_services_controller.dart';
import 'package:yelpax/shared/widgets/custom_shimmer.dart';

import '../../../../core/constants/height.dart';
import '../../../../core/constants/width.dart';
import '../../../../shared/widgets/custom_input.dart';

class HomeServicesScreen extends StatefulWidget {
  const HomeServicesScreen({super.key});

  @override
  State<HomeServicesScreen> createState() => _HomeServicesScreenState();
}

class _HomeServicesScreenState extends State<HomeServicesScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final theme = Provider.of<ThemeProvider>(context, listen: false);
      theme.setTheme(ThemeModeType.homeServices);
      Provider.of<HomeServicesController>(
        context,
        listen: false,
      ).getCategories();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, Username'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () => print('Pressed'),
            icon: Icon(Icons.person_outlined),
          ),
        ],
      ),

      body: Container(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomInputField(
                label: 'Search',
                hintText: 'What do you need to help with',
              ),
              SizedBox(height: 16),
              Text(
                'Most Popular',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.left,
              ),
              Consumer<HomeServicesController>(
                builder: (context, value, child) {
                  if (value.categoryLoading) {
                    return CustomShimmer(
                      layoutType: ShimmerLayoutType.horizontalList,
                    );
                  }
                  if (value.categories == null) {
                    return InkWell(child: Icon(Icons.refresh));
                  }
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    width: width(context),
                    height: height(context) / 6,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: value.categories.length,

                      itemBuilder: (context, index) {
                        return _buildCategory(
                          context,
                          value.categories,
                          () {
                            print(
                              'Tapped on Category : ${value.categories[index]}',
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
              SizedBox(height: 50),
              Text(
                'Based on your activity',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.left,
              ),
              Consumer<HomeServicesController>(
                builder: (context, value, child) {
                  if (value.categoryLoading) {
                    return CustomShimmer(
                      layoutType: ShimmerLayoutType.grid,
                      height: height(context) / 2,
                      itemCount: 6,
                    );
                  }
                  if (value.categories == null) {
                    return InkWell(child: Icon(Icons.refresh));
                  }

                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    width: width(context),
                    height: height(context) / 1.5,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: value.categories.length,

                      itemBuilder: (context, index) {
                        return _buildCategory(
                          context,
                          value.categories,
                          () {
                            print(
                              'Tapped on Category : ${value.categories[index]}',
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
            ],
          ),
        ),
      ),
    );
  }
}

//custom static widgets
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
            height: height(context) / 13,
            width: width(context) / 1.8,
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
