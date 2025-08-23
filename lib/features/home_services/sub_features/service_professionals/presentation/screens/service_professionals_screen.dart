import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/features/home_services/sub_features/service_professionals/presentation/controllers/service_professionals_controller.dart';
import 'package:yelpax/features/home_services/sub_features/service_professionals/presentation/widgets/professional_card_widget.dart';
import 'package:yelpax/features/home_services/sub_features/service_professionals/presentation/widgets/professional_filter_widget.dart';
import 'package:yelpax/shared/widgets/custom_shimmer.dart';

class ServiceProfessionalsScreen extends StatefulWidget {
  final dynamic serviceDetails;

  const ServiceProfessionalsScreen({Key? key, required this.serviceDetails})
    : super(key: key);

  @override
  State<ServiceProfessionalsScreen> createState() =>
      _ServiceProfessionalsScreenState();
}

class _ServiceProfessionalsScreenState
    extends State<ServiceProfessionalsScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          ServiceProfessionalsController(widget.serviceDetails),
      child: const _ServiceProfessionalsView(),
    );
  }
}

class _ServiceProfessionalsView extends StatelessWidget {
  const _ServiceProfessionalsView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ServiceProfessionalsController>();
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Service Professionals',
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      child: SafeArea(child: _buildBody(controller, theme, textTheme)),
    );
  }

  Widget _buildBody(
    ServiceProfessionalsController controller,
    ThemeData theme,
    TextTheme textTheme,
  ) {
    if (controller.professionalsLoading) {
      return const Center(child: CustomShimmer());
    }

    if (controller.professionals.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("No professionals found", style: textTheme.bodyLarge),
            const SizedBox(height: 16),
            CupertinoButton.filled(
              child: const Text("Retry"),
              onPressed: controller.retry,
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(controller, textTheme),
        const SizedBox(height: 8),
        _buildCriteriaTextAndFilter(textTheme),
        const SizedBox(height: 8),
        _buildProfessionalsList(controller, theme, textTheme),
      ],
    );
  }

  Widget _buildHeader(
    ServiceProfessionalsController controller,
    TextTheme textTheme,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        'Top 3 matching ${controller.serviceDetails['name']}',
        style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCriteriaTextAndFilter(TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Our Criteria',
            style: textTheme.bodyLarge?.copyWith(
              color: CupertinoColors.systemGrey,
            ),
          ),
          ProfessionalFilterWidget(),
        ],
      ),
    );
  }

  Widget _buildProfessionalsList(
    ServiceProfessionalsController controller,
    ThemeData theme,
    TextTheme textTheme,
  ) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: controller.professionals.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final professional = controller.professionals[index];
          return ProfessionalCardWidget(
            professional: professional,
            onTap: () => controller.openCategory(professional, context),
          );
        },
      ),
    );
  }
}
