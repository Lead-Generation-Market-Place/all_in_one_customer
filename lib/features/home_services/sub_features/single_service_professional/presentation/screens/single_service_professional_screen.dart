import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/core/injection_container.dart';
import '../controllers/single_service_professional_controller.dart';
import '../widgets/single_service_pro_personnel_details_widget.dart';

class SingleServiceProfessionalScreen extends StatefulWidget {
  final String proId;
  
  const SingleServiceProfessionalScreen({
    super.key, 
    required this.proId
  });

  @override
  State<SingleServiceProfessionalScreen> createState() =>
      _SingleServiceProfessionalScreenState();
}

class _SingleServiceProfessionalScreenState
    extends State<SingleServiceProfessionalScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SingleServiceProfessionalController(
        homeServicesFindprosUsecase: getIt(),
        proId: widget.proId,
      ),
      child: const _ProfessionalScreenContent(),
    );
  }
}

class _ProfessionalScreenContent extends StatelessWidget {
  const _ProfessionalScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Consumer<SingleServiceProfessionalController>(
        builder: (context, controller, child) {
          if (controller.proLoading) {
            return _buildLoadingState();
          }
          
          if (controller.errorMessage.isNotEmpty) {
            return _buildErrorState(context, controller);
          }
          
          if (controller.getProfessionalEntity == null) {
            return _buildEmptyState(context, controller);
          }
          
          return _buildSuccessState(context, controller);
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Column(
      children: [
        _AppBarSection(isLoading: true),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator.adaptive(),
                SizedBox(height: 16),
                Text(
                  'Loading professional details...',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context, SingleServiceProfessionalController controller) {
    return Column(
      children: [
        const _AppBarSection(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 80,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 24),
                Text(
                  "Oops! Something went wrong",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  controller.errorMessage,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: controller.retry,
                      icon: const Icon(Icons.refresh),
                      label: const Text("Try Again"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    OutlinedButton.icon(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text("Go Back"),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context, SingleServiceProfessionalController controller) {
    return Column(
      children: [
        const _AppBarSection(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_off_outlined,
                  size: 80,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 24),
                Text(
                  "Professional Not Found",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  "The professional you're looking for is not available or has been removed.",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: controller.retry,
                      icon: const Icon(Icons.refresh),
                      label: const Text("Retry"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    OutlinedButton.icon(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text("Go Back"),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessState(BuildContext context, SingleServiceProfessionalController controller) {
    return Column(
      children: [
        _AppBarSection(
          professionalName: controller.getProfessionalEntity?.businessName,
        ),
        Expanded(
          child: SingleServiceProPersonnelDetailsWidget(
            professional: controller.getProfessionalEntity!,
          ),
        ),
      ],
    );
  }
}

class _AppBarSection extends StatelessWidget {
  final bool isLoading;
  final String? professionalName;
  
  const _AppBarSection({
    this.isLoading = false,
    this.professionalName,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: Colors.grey,
          ),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: isLoading 
          ? const Text(
              'Professional',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            )
          : Text(
              professionalName ?? 'Professional',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
      centerTitle: true,
      actions: [
        if (!isLoading) ...[
          _buildActionButton(
            icon: Icons.favorite_border_rounded,
            onPressed: () => _toggleFavorite(context),
          ),
          _buildActionButton(
            icon: Icons.share_outlined,
            onPressed: () => _shareProfessional(context),
          ),
          const SizedBox(width: 8),
        ],
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      icon: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 20,
          color: Colors.grey[700],
        ),
      ),
      onPressed: onPressed,
    );
  }

  void _toggleFavorite(BuildContext context) {
    // Implement favorite functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Added to favorites'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _shareProfessional(BuildContext context) {
    // Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Sharing professional...'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}