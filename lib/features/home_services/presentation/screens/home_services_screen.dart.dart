import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_entity.dart';
import 'package:yelpax/features/home_services/presentation/widgets/popular_categories_widget.dart';
import 'package:yelpax/features/home_services/presentation/widgets/section_title_widget.dart';
import '../../../../app/presentation/shell/widgets/custom_bottom_nav.dart';
import '../../../../config/routes/router.dart';
import '../../../../config/themes/theme_mode_type.dart';
import '../../../../config/themes/theme_provider.dart';
import '../controllers/home_services_controller.dart';
import 'home_services_promotion_screen.dart';
import '../widgets/app_bar_widget.dart';
import '../../../../shared/widgets/custom_shimmer.dart';
import '../../../../core/constants/height.dart';
import '../../../../core/constants/width.dart';
import 'search_professional_screen.dart';

class HomeServicesScreen extends StatefulWidget {
  const HomeServicesScreen({super.key});

  @override
  State<HomeServicesScreen> createState() => _HomeServicesScreenState();
}

class _HomeServicesScreenState extends State<HomeServicesScreen> {
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final theme = Provider.of<ThemeProvider>(context, listen: false);
      final controller = Provider.of<HomeServicesController>(
        context,
        listen: false,
      );

      theme.setTheme(ThemeModeType.homeServices);
      controller.getCategories();
      controller
          .fetchHomeServices(); //fetching home services when user navigated to home screen of home services
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBarWidget(),
        preferredSize: Size.fromHeight(height(context) / 15),
      ),
      drawer: Drawer(),
      backgroundColor: Colors.white,
      body: _buildBody(),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        onTap: (value) => print(value),
      ),
    );
  }

  Widget _buildBody() {
    final _controller = context.read<HomeServicesController>();
    return Container(
      padding: const EdgeInsets.all(16),
      child: RefreshIndicator.adaptive(
        onRefresh: () => _controller.retry(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  BackButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, AppRouter.home),
                  ),
                  Text(
                    'Home Services',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              SearchProfessionalScreen(),
              const SizedBox(height: 16),
              HomeServicesPromotionScreen(),
              PopularCategoriesWidget(),
              const SizedBox(height: 50),
         //     _buildActivityBasedCategories(),
              _buildDivider(),
         //     _buildAddressBasedCategory(),
              _buildYourGoals(),
              // _buildDivider(),
              // _buildPopularCategories(),
              _buildDivider(),
              //  _buildPopularCategories(),
              _buildYourGoals(),
              //   // _buildDivider(),
              _buildMoreGuides(),
              _buildDivider(),
          //    _buildSectionTitle('Outdoor upkeep'),
              //     _buildPopularCategories(),
              //     _buildDivider(),
              //     _buildSectionTitle('Essential Home Service'),
              //     _buildPopularCategories(),
              // _buildDivider(),
              // _buildSectionTitle('Moving into a new home'),
              // _buildPopularCategories(),
              // _buildDivider(),
              // _buildSectionTitle('Caring for a pet'),
              // _buildPopularCategories(),
              // _buildDivider(),
              // _buildSectionTitle('Planing a wedding'),
              // _buildPopularCategories(),
              // _buildDivider(),
              // _buildSectionTitle('Home office essentials'),
              // _buildPopularCategories(),
              // _buildDivider(),
              // _buildSectionTitle('Virtual lessons'),
              // _buildPopularCategories(),
              // _buildDivider(),
              // _buildSectionTitle('Financial advising'),
              // _buildPopularCategories(),
              // _buildDivider(),
              // _buildSectionTitle('Online tutoring'),
              // _buildPopularCategories(),
              _buildDivider(),
              _buildGetInspiration(),
              _buildDivider(),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildActivityBasedCategories() {
  //   return Consumer<HomeServicesController>(
  //     builder: (context, controller, _) {
  //       if (controller.categoryLoading) {
  //         return CustomShimmer(
  //           layoutType: ShimmerLayoutType.grid,
  //           height: height(context) / 2,
  //           crossAxisCount: 2,
  //           itemCount: 6,
  //         );
  //       }

  //       if (controller.categories == null) {
  //         return InkWell(
  //           onTap: () => controller.getCategories(),
  //           child: const Icon(Icons.refresh),
  //         );
  //       }
  //       //    print(controller.categories.length);
  //       return _buildGridCategoryList(controller.categories, controller);
  //     },
  //   );
  // }

  // Widget _buildGridCategoryList(
  //   List categories,
  //   HomeServicesController controller,
  // ) {
  //   return Card(
  //     child: Column(
  //       children: [
  //         _buildSectionTitle('Activity Based Services'),
  //         Container(
  //           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
  //           width: width(context),
  //           height: height(context) / 2.5,
  //           child: GridView.builder(
  //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //               crossAxisCount: 2,
  //             ),
  //             scrollDirection: Axis.vertical,
  //             itemCount: categories.length,
  //             itemBuilder: (context, index) => _buildCategoryItem(
  //               context,
  //               categories[index]['name'],
  //               categories[index]['imageUrl'],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildAddressBasedCategory() {
  //   return Consumer<HomeServicesController>(
  //     builder: (context, value, child) {
  //       if (value.categoryLoading) {
  //         return CustomShimmer(
  //           layoutType: ShimmerLayoutType.list,
  //           itemCount: 3,
  //         );
  //       }
  //       if (value.isAddressExists) {
  //         return _buildHorizontalCategoryList(
  //           'For Your Home',
  //           value.homeServices,
  //         );
  //       }
  //       return Column(
  //         children: [
  //           Text(
  //             'Add your address for more accureate pricing, find nearby pros, and useful tips.',
  //             style: Theme.of(context).textTheme.bodySmall,
  //           ),
  //           Row(
  //             children: [
  //               TextButton(
  //                 onPressed: () => print('adding Address'),
  //                 child: Text('Add your address ->'),
  //               ),
  //             ],
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Widget _buildYourGoals() {
    return Consumer<HomeServicesController>(
      builder: (context, value, child) {
        if (value.categoryLoading) {
          return CustomShimmer(
            layoutType: ShimmerLayoutType.list,
            itemCount: 4,
          );
        }
        if (value.categories.isEmpty) {
          return Icon(Icons.error_outline);
        }
        return Column(
          children: [
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Theme.of(context).secondaryHeaderColor,
                    width: width(context),
                    height: height(context) / 5,
                    child: Image.network(
                      'https://images.pexels.com/photos/4246109/pexels-photo-4246109.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SectionTitleWidget(title: 'Keep things clean'),
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: width(context),
                    height: height(context) / 3.7,
                    child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) =>
                          _buildCardForGoals(value.categories, index),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Card(
                      child: ListTile(
                        title: Text(
                          'View Guide ->',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Card(
              child: ListTile(
                title: Text(
                  'Looking for  something tailored to you?',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                subtitle: TextButton(
                  onPressed: () => print('Tell us about button pressed'),
                  child: Text('Tell us about your goals'),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMoreGuides() {
    return Consumer<HomeServicesController>(
      builder: (context, value, child) {
        if (value.categoryLoading) {
          return CustomShimmer(
            layoutType: ShimmerLayoutType.grid,
            crossAxisCount: 1,
            itemCount: 2,
          );
        }
        if (value.categories.isEmpty) {
          return Icon(Icons.error_outline);
        }
        return Container(
          width: width(context),
          height: height(context) / 2.5,

          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      height: height(context) / 6,
                      width: width(context) / 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.pink,
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            'https://images.pexels.com/photos/6196688/pexels-photo-6196688.jpeg',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.auto_graph),
                          Text(
                            'Increase home value',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            'Projects that can help you add value to your home.',
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 4,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildGetInspiration() {
    return Consumer<HomeServicesController>(
      builder: (context, controller, _) {
        if (controller.categoryLoading) {
          return const CustomShimmer(
            layoutType: ShimmerLayoutType.horizontalList,
            crossAxisCount: 1,
            itemCount: 1,
          );
        }

        if (controller.categories == null) {
          return InkWell(
            onTap: () => controller.getCategories(),
            child: const Icon(Icons.refresh),
          );
        }

        return Card(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        'Get inspiration from Yelpax projects we love.',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      TextButton(
                        onPressed: () => print('See our favorites'),
                        child: Text('See our favorites ->'),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  height: height(context) / 6,
                  width: width(context) / 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.pink,
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/splash_1.jpg'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDivider() {
    return Container(margin: const EdgeInsets.all(24), child: Divider());
  }

  Widget _buildCardForGoals(List category, int index) {
    return Card(
      child: ListTile(
        leading: Image.network(category[index]['imageUrl'], fit: BoxFit.cover),
        title: Text(
          category[index]['name'],
          style: Theme.of(context).textTheme.titleSmall,
        ),
        subtitle: Text(
          '\$${100}-150 avg.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: IconButton(
          onPressed: () => print('saved'),
          icon: Icon(Icons.bookmark_outline),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Center(
      child: Column(
        children: [
          Text("Don't see what you're looking for?"),
          TextButton(
            onPressed: () => Logger().d('Search all services clicked'),
            child: Text('Search all services'),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
