import 'package:flutter/material.dart';
import 'package:yelpax/core/constants/height.dart';
import 'package:yelpax/core/constants/width.dart';
import 'package:yelpax/features/featured/presentation/widgets/notice_banner.dart';
import 'package:yelpax/shared/widgets/custom_input.dart';

class FeaturedScreen extends StatefulWidget {
  const FeaturedScreen({super.key});

  @override
  State<FeaturedScreen> createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        cacheExtent: 250,
        slivers: [
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,

              title: Padding(
                padding: const EdgeInsets.only(right: 8, top: 16, left: 8),
                child: CustomInputField(
                  label: 'label',
                  hintText: 'hintText',
                  inputType: TextInputType.text,
                  suffixIcon: Icons.search_outlined,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
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
            ]),
          ),
        ],
      ),
    );
  }
}
