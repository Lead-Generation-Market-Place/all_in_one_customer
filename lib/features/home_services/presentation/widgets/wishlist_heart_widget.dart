// shared/widgets/wishlist_heart_widget.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_entity.dart';
import 'package:yelpax/features/home_services/presentation/controllers/home_services_wishlist_controller.dart';

class WishlistHeartWidget extends StatefulWidget {
  final HomeServicesEntity service;
  final double size;
  final Color? color;

  const WishlistHeartWidget({
    Key? key,
    required this.service,
    this.size = 24.0,
    this.color,
  }) : super(key: key);

  @override
  State<WishlistHeartWidget> createState() => _WishlistHeartWidgetState();
}

class _WishlistHeartWidgetState extends State<WishlistHeartWidget> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final wishlistController = context.watch<HomeServicesWishlistController>();
    final isWishlisted = wishlistController.isWishlisted(widget.service.id);

    return IgnorePointer(
      ignoring: _isProcessing,
      child: IconButton(
        iconSize: widget.size,
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(minWidth: widget.size),
        icon: _isProcessing
            ? SizedBox(
                width: widget.size,
                height: widget.size,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    widget.color ?? Colors.grey,
                  ),
                ),
              )
            : Icon(
                isWishlisted ? Icons.favorite : Icons.favorite_border,
                color: isWishlisted 
                    ? Colors.red 
                    : widget.color ?? Colors.grey,
              ),
        onPressed: () async {
          setState(() => _isProcessing = true);
          await wishlistController.toggleWishlist(widget.service);
          setState(() => _isProcessing = false);
        },
      ),
    );
  }
}