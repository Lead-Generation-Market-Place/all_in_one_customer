import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_wishlist_entity.dart';
import 'package:yelpax/features/home_services/presentation/controllers/home_services_wishlist_controller.dart';

import '../../../../core/constants/asset_constants.dart';
import '../../../../core/constants/height.dart';
import '../widgets/app_bar_widget.dart';

class HomeServicesWishlistScreen extends StatefulWidget {
  const HomeServicesWishlistScreen({Key? key}) : super(key: key);

  @override
  State<HomeServicesWishlistScreen> createState() =>
      _HomeServicesWishlistScreenState();
}

class _HomeServicesWishlistScreenState
    extends State<HomeServicesWishlistScreen> {
  Future<void> _intialize() async {
    var controller = Provider.of<HomeServicesWishlistController>(
      context,
      listen: false,
    );
    await controller.fetchUserWishlist();
  }

  // void _removeItem(String id) {
  //   final index = _items.indexWhere((element) => element.id == id);
  //   if (index == -1) return;
  //   final removed = _items[index];
  //   setState(() => _items.removeWhere((i) => i.id == id));
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text('Removed "${removed.title}" from wishlist'),
  //       action: SnackBarAction(
  //         label: 'UNDO',
  //         onPressed: () {
  //           setState(() {
  //             _items.insert(0, removed);
  //           });
  //         },
  //       ),
  //     ),
  //   );
  // }

  // void _clearAll() {

  //   showDialog(
  //     context: context,
  //     builder: (ctx) => AlertDialog(
  //       title: const Text('Clear wishlist'),
  //       content: const Text('Are you sure you want to remove all items?'),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.of(ctx).pop(),
  //           child: const Text('Cancel'),
  //         ),
  //         TextButton(
  //           onPressed: () {
  //             setState(() => _items.clear());
  //             Navigator.of(ctx).pop();
  //           },
  //           child: const Text('Clear'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void _browseServices() {
    // Placeholder: wire navigation to services screen in real app.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Navigate to services list (not implemented)'),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _intialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height(context) / 15),
        child: AppBarWidget(title: const Text('Wishlist')),
      ),

      body: Consumer<HomeServicesWishlistController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.error != null) {
            return Center(child: Text('Error: ${controller.error}'));
          } else if (controller.wishlists.isEmpty) {
            return _buildEmptyState(context);
          } else {
            return _buildList(controller.wishlists);
          }
        },
      ),
      //  _items.isEmpty ? _buildEmptyState(context) : _buildList(),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.favorite_border,
              size: 88,
              color: theme.colorScheme.primary.withOpacity(0.6),
            ),
            const SizedBox(height: 18),
            Text(
              'Your wishlist is empty',
              style: theme.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Save services you like to find them quickly later.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _browseServices,
              icon: const Icon(Icons.search),
              label: const Text('Browse services'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<HomeServicesWishlistEntity> wishlist) {
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: wishlist.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = wishlist[index].homeServicesEntity;
        return Dismissible(
          key: ValueKey(item.id),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (_) => print("dismissed"),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 64,
                  height: 64,
                  child: Image.network(
                    AssetConstants.AssetApi + item.image_url,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.miscellaneous_services, size: 36),
                    ),
                  ),
                ),
              ),
              title: Text(item.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  //  const SizedBox(height: 6),
                  // services const and ratings widget here
                  // Row(
                  //   children: [
                  //     Container(
                  //       padding: const EdgeInsets.symmetric(
                  //         horizontal: 8,
                  //         vertical: 4,
                  //       ),
                  //       decoration: BoxDecoration(
                  //         color: Colors.green.shade50,
                  //         borderRadius: BorderRadius.circular(6),
                  //       ),
                  //       child: Text(
                  //         wishlist[index].homeServicesEntity.description,
                  //         style: const TextStyle(fontWeight: FontWeight.w600),
                  //       ),
                  //     ),
                  //     const SizedBox(width: 8),
                  //     Icon(Icons.star, size: 16, color: Colors.amber.shade700),
                  //     const SizedBox(width: 4),
                  //     Text('${4.5}'),
                  //   ],
                  // ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.favorite, color: Colors.redAccent),
                onPressed: ()  =>
                     Provider.of<HomeServicesWishlistController>(
                      context,
                      listen: false,
                    ).removeFromWishlist(wishlist[index].id),
                tooltip: 'Remove from wishlist',
              ),
           
            ),
          ),
        );
      },
    );
  }
}
