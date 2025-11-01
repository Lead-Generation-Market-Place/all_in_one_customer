import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_wishlist_entity.dart';
import 'package:yelpax/features/home_services/presentation/controllers/home_services_wishlist_controller.dart';

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

  final List<WishlistItem> _items = [
    WishlistItem(
      id: '1',
      title: 'Deep Home Cleaning',
      provider: 'Sparkle Cleaners',
      price: 99.0,
      rating: 4.8,
      imageUrl:
          'https://images.unsplash.com/photo-1581574200320-1a1e0fb13c3b?w=800&q=60',
    ),
    WishlistItem(
      id: '2',
      title: 'Plumbing Repair - Kitchen',
      provider: 'QuickFix Plumbing',
      price: 75.0,
      rating: 4.5,
      imageUrl:
          'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=800&q=60',
    ),
    WishlistItem(
      id: '3',
      title: 'AC Maintenance',
      provider: 'CoolTech Services',
      price: 49.0,
      rating: 4.6,
      imageUrl:
          'https://images.unsplash.com/photo-1582719478177-1d07f59b3e7b?w=800&q=60',
    ),
  ];

  void _removeItem(String id) {
    final index = _items.indexWhere((element) => element.id == id);
    if (index == -1) return;
    final removed = _items[index];
    setState(() => _items.removeWhere((i) => i.id == id));
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Removed "${removed.title}" from wishlist'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _items.insert(0, removed);
            });
          },
        ),
      ),
    );
  }

  void _clearAll() {
    if (_items.isEmpty) return;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear wishlist'),
        content: const Text('Are you sure you want to remove all items?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() => _items.clear());
              Navigator.of(ctx).pop();
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

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

      // AppBar(
      //   title: ,
      //   actions: [
      //     if (_items.isNotEmpty)
      //       IconButton(
      //         icon: const Icon(Icons.delete_sweep_outlined),
      //         tooltip: 'Clear all',
      //         onPressed: _clearAll,
      //       ),
      //   ],
      // ),
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
          onDismissed: (_) => _removeItem(item.id),
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
                    item.image_url,
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
                  Text(item.description),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '\$${40}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.star, size: 16, color: Colors.amber.shade700),
                      const SizedBox(width: 4),
                      Text('${4.5}'),
                    ],
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.favorite, color: Colors.redAccent),
                onPressed: () => _removeItem(item.id),
                tooltip: 'Remove from wishlist',
              ),
              onTap: () {
                // Placeholder for service detail navigation
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Open "${item.name}" (not implemented)'),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class WishlistItem {
  final String id;
  final String title;
  final String provider;
  final double price;
  final double rating;
  final String imageUrl;

  WishlistItem({
    required this.id,
    required this.title,
    required this.provider,
    required this.price,
    required this.rating,
    required this.imageUrl,
  });
}
