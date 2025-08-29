import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

enum ShimmerLayoutType { list, grid, horizontalList, single }

class CustomShimmer extends StatelessWidget {
  final double? height;
  final double? width;
  final int? itemCount;
  final ShimmerLayoutType layoutType;
  final int crossAxisCount;
  final EdgeInsetsGeometry? margin;
  final Axis scrollDirection;
  final double? itemWidth; // Specific width for horizontal list items

  const CustomShimmer({
    super.key,
    this.height,
    this.width,
    this.itemCount,
    this.layoutType = ShimmerLayoutType.list,
    this.crossAxisCount = 3,
    this.margin,
    this.scrollDirection = Axis.vertical,
    this.itemWidth,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final shimmerHeight = height ?? media.size.height / 12;
    final shimmerWidth = width ?? media.size.width;
    final count = itemCount ?? 12;

    return SizedBox(
      width: shimmerWidth,
      height: layoutType == ShimmerLayoutType.horizontalList
          ? shimmerHeight
          : null,
      child: _buildShimmerLayout(context, shimmerHeight, shimmerWidth, count),
    );
  }

  Widget _buildShimmerLayout(
    BuildContext context,
    double height,
    double width,
    int count,
  ) {
    switch (layoutType) {
      case ShimmerLayoutType.list:
        return _buildListShimmer(height, width, count);
      case ShimmerLayoutType.grid:
        return _buildGridShimmer(height, width, count, context);
      case ShimmerLayoutType.horizontalList:
        return _buildHorizontalListShimmer(height, width, count, context);
      case ShimmerLayoutType.single:
        return _buildSingleShimmer(context);
    }
  }

  Widget _buildListShimmer(double height, double width, int count) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: count,
      itemBuilder: (context, index) => _buildListTileShimmer(height, width),
    );
  }

  Widget _buildHorizontalListShimmer(
    double height,
    double width,
    int count,
    BuildContext context,
  ) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: count,
      itemBuilder: (context, index) => SizedBox(
        width: itemWidth ?? width * 0.4, // Default to 40% of container width
        child: _buildListTileShimmer(height, width),
      ),
    );
  }

  Widget _buildListTileShimmer(double height, double width) {
    return SizedBox(
      height: height,
      width: width,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 14,
                      width: width * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 12,
                      width: width * 0.35,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 10,
                      width: width * 0.2,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridShimmer(
    double height,
    double width,
    int count,
    BuildContext context,
  ) {
    return SizedBox(
      height: height,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: count,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 0.8,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (context, index) => _buildGridCardShimmer(context),
      ),
    );
  }

  Widget _buildSingleShimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).primaryColor,
      highlightColor: Colors.white,
      child: Container(
        margin: margin ?? const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildGridCardShimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).primaryColor,
      highlightColor: Colors.white,
      child: Container(
        margin: margin ?? const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
