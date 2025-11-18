import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yelpax/core/injection_container.dart';
import 'package:yelpax/core/utils/url_helper.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_fetch_professionals_entity.dart';
import 'package:yelpax/features/home_services/sub_features/service_professionals_id_zipcode/controllers/home_services_findpros_controller.dart';
import '../../../../../shared/widgets/styled_asterisk_name.dart';
import '../../../../../shared/widgets/star_rating_widget.dart';

class ServiceProfessionalsScreen extends StatefulWidget {
  final String serviceId;
  final String serviceName;
  final String zipCode;
  
  const ServiceProfessionalsScreen({
    Key? key,
    required this.serviceId,
    required this.serviceName,
    this.zipCode = '',
  }) : super(key: key);

  @override
  State<ServiceProfessionalsScreen> createState() =>
      _ServiceProfessionalsScreenState();
}

class _ServiceProfessionalsScreenState
    extends State<ServiceProfessionalsScreen> {


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeServicesFindprosController>(
      create: (context) => getIt<HomeServicesFindprosController>()
        ..wrapper(widget.serviceId, widget.zipCode),
      child: _ServiceProfessionalsView(
        serviceName: widget.serviceName,
        serviceId: widget.serviceId,
      ),
    );
  }
}

class _ServiceProfessionalsView extends StatelessWidget {
  final String serviceName;
  final String serviceId;
  
  const _ServiceProfessionalsView({
    required this.serviceName,
    required this.serviceId,
  });

  @override
  Widget build(BuildContext context) {
      final controller = Provider.of<HomeServicesFindprosController>(context);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Service Professionals',
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.filter_list_rounded,
                size: 20,
                color: Colors.grey,
              ),
            ),
            onPressed: () => _showFilterOptions(context, controller),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.retry(),
        child: _buildBody(controller, theme, textTheme, context,serviceId),
      ),
    );
  }

  Widget _buildBody(
    HomeServicesFindprosController controller,
    ThemeData theme,
    TextTheme textTheme,
    BuildContext context,
    String serviceId,
  ) {
    if (controller.professionalsLoading) {
      return _buildLoadingState();
    }

    if (controller.error.isNotEmpty) {
      return _buildErrorState(controller, context, textTheme);
    }

    if (controller.professionals.isEmpty) {
      return _buildEmptyState(context, textTheme);
    }

    return _buildSuccessState(serviceId,controller, textTheme);
  }
  Widget _buildLoadingState() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar shimmer
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 16),
                // Content shimmer
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 12,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 12,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 36,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              height: 36,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _buildErrorState(
    HomeServicesFindprosController controller,
    BuildContext context,
    TextTheme textTheme,
  ) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 24),
          Text(
            "Unable to Load Professionals",
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            controller.error,
            style: textTheme.bodyMedium?.copyWith(
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
                icon: const Icon(Icons.refresh_rounded),
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline_rounded,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 24),
          Text(
            "No Professionals Found",
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            "We couldn't find any professionals for $serviceName in your area.",
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_rounded),
            label: const Text("Browse Other Services"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[600],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessState(
    String serviceId,
    HomeServicesFindprosController controller,
    TextTheme textTheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(controller, textTheme),
        const SizedBox(height: 8),
        // ProfessionalFilterWidget(controller: controller),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: controller.professionals.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final professional = controller.professionals[index];
              return ProfessionalCard(
                professional: professional,
                onTap: () => _openProfessionalProfile(context, professional),
                onOpenDetails: () => controller.openProfessionalDetails(context, index),
                onOpenQuotation: () => controller.openQuestionFlow(
                  professional.questions,
                  context, serviceId: serviceId,
                  professionalId: professional.professional.id,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(
    HomeServicesFindprosController controller,
    TextTheme textTheme,
  ) {
    final prosCount = controller.professionals.length;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: RichText(
        text: TextSpan(
          style: textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          children: [
            const TextSpan(text: '🔍 '),
            TextSpan(
              text: '$prosCount ',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blue[600],
              ),
            ),
            TextSpan(text: 'professional${prosCount == 1 ? '' : 's'} found for '),
            TextSpan(
              text: serviceName,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterOptions(BuildContext context, HomeServicesFindprosController controller) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filter Professionals',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // Add filter options here
              ListTile(
                leading: const Icon(Icons.star_rounded),
                title: const Text('Top Rated'),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                onTap: () {
                  Navigator.pop(context);
                  // Implement rating filter
                },
              ),
              ListTile(
                leading: const Icon(Icons.attach_money_rounded),
                title: const Text('Price Range'),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                onTap: () {
                  Navigator.pop(context);
                  // Implement price filter
                },
              ),
              ListTile(
                leading: const Icon(Icons.location_on_rounded),
                title: const Text('Distance'),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                onTap: () {
                  Navigator.pop(context);
                  // Implement distance filter
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Apply Filters'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openProfessionalProfile(BuildContext context, HomeServicesFetchProfessionalsEntity professional) {
    // Implement professional profile navigation
    print("Opening professional profile: ${professional.professional.businessName}");
  }
}

class ProfessionalCard extends StatelessWidget {
  final HomeServicesFetchProfessionalsEntity professional;
  final VoidCallback onTap;
  final VoidCallback onOpenQuotation;
  final VoidCallback onOpenDetails;

  const ProfessionalCard({
    super.key,
    required this.professional,
    required this.onTap,
    required this.onOpenQuotation,
    required this.onOpenDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderSection(context),
                const SizedBox(height: 16),
                _buildStatsSection(context),
                const SizedBox(height: 16),
                _buildDescriptionSection(context),
                const SizedBox(height: 16),
                _buildActionButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAvatar(),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNameAndBadge(context),
              const SizedBox(height: 8),
              _buildRatingSection(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar() {
    return Stack(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey[200]!, width: 2),
          ),
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: UrlHelper.fixImageUrl(professional.professional.profileImage),
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[200],
                child: const Icon(
                  Icons.person_rounded,
                  color: Colors.grey,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 2,
          right: 2,
          child: Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNameAndBadge(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              children: StyledAsteriskName(
                professional.professional.businessName,
                Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.amber[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.amber[100]!),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.verified_rounded, size: 14, color: Colors.amber[700]),
              const SizedBox(width: 4),
              Text(
                'Pro',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.amber[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRatingSection(BuildContext context) {
    return Row(
      children: [
        StarRatingWidget(
          initialRating: professional.professional.ratingAverage.toDouble(),
          size: 18,
        ),
        const SizedBox(width: 8),
        Text(
          professional.professional.ratingAverage.toString(),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '(${professional.professional.totalReview} reviews)',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    return Row(
      children: [
        _buildStatItem(
          context,
          Icons.work_history_rounded,
          '${professional.professional.totalHire} Hires',
        ),
        const SizedBox(width: 16),
        _buildStatItem(
          context,
          Icons.attach_money_rounded,
          '${professional.minimumPrice}\$ Min',
        ),
        const SizedBox(width: 16),
        _buildStatItem(
          context,
          Icons.schedule_rounded,
          'Fast Response',
        ),
      ],
    );
  }

  Widget _buildStatItem(BuildContext context, IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.blue[600]),
        const SizedBox(width: 4),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection(BuildContext context) {
    return Text(
      professional.professional.introduction,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Colors.grey[600],
        height: 1.4,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onOpenDetails,
            icon: const Icon(Icons.info_outline_rounded, size: 18),
            label: const Text('Details'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onOpenQuotation,
            icon: const Icon(Icons.request_quote_rounded, size: 18),
            label: const Text('Get Quote'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[600],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}