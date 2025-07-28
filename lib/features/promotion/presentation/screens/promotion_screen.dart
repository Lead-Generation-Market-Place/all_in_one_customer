import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/core/constants/height.dart';
import 'package:yelpax/core/constants/width.dart';
import 'package:yelpax/features/promotion/presentation/controllers/promotion_controller.dart';
import 'package:yelpax/features/promotion/presentation/widgets/notice_banner.dart';
import 'package:yelpax/features/promotion/presentation/widgets/sliver_appbar.dart';
import 'package:yelpax/shared/widgets/custom_input.dart';

class PromotionScreen extends StatefulWidget {
  const PromotionScreen({super.key});

  @override
  State<PromotionScreen> createState() => _PromotionScreenState();
}

class _PromotionScreenState extends State<PromotionScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<PromotionController>(context, listen: false).onInit();
    super.initState();
  }

  Future dispos() async {
    Provider.of<PromotionController>(context, listen: false).onDispose();
  }

  @override
  void dispose() async {
    await dispos();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PromotionController>(context, listen: false);

    return Scaffold(
      body: CustomScrollView(
        controller: provider.scrollController,
        slivers: [
          buildSliverAppbar(context),
          SliverList(
            delegate: SliverChildListDelegate([
              Consumer<PromotionController>(
                builder: (context, value, child) {
                  return value.isLoading
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
    );
  }
}
