import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/core/injection_container.dart';
import '../controllers/home_services_findpros_controller.dart';
import '../widgets/professional_card_widget.dart';
import '../../../../../shared/widgets/custom_shimmer.dart';

class ServiceProfessionalsScreen extends StatefulWidget {
  final String serviceId;
  final String serviceName;

  const ServiceProfessionalsScreen({
    Key? key,
    required this.serviceId,
    required this.serviceName,
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
      create: (context) => getIt<HomeServicesFindprosController>()..getProfessionals(widget.serviceId),
      child:  _ServiceProfessionalsView(serviceName: widget.serviceName,),
    );
  }
}

class _ServiceProfessionalsView extends StatelessWidget {
  String serviceName;
   _ServiceProfessionalsView({required this.serviceName});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeServicesFindprosController>();
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return RefreshIndicator(
      onRefresh: () => controller.retry(),
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            'Service Professionals',
            style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        child: SafeArea(child: _buildBody(controller, theme, textTheme, context,serviceName)),
      ),
    );
  }

  Widget _buildBody(
    HomeServicesFindprosController controller,
    ThemeData theme,
    TextTheme textTheme,
    BuildContext context,
    String serviceName
  ) {
    if (controller.professionalsLoading) {
      return const Center(child: CustomShimmer());
    }

    if (controller.professionals.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("No professionals found for", style: textTheme.bodyLarge),
            Text(serviceName, style: textTheme.titleSmall,),
            
            const SizedBox(height: 16),
            CupertinoButton.filled(
              child: const Text("Back"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(controller, textTheme,serviceName),
        const SizedBox(height: 8),
        //    ProfessionalFilterWidget(textTheme: textTheme, controller: controller),
        const Divider(),
        const SizedBox(height: 8),
        _buildProfessionalsList(controller, theme, textTheme),
      ],
    );
  }

  Widget _buildHeader(
    HomeServicesFindprosController controller,
    TextTheme textTheme,
    String serviceName
  ) {
    String pros=controller.professionals.length.toString();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(text: 'Top ', style: textTheme.bodyMedium),
            TextSpan(text: pros, style: textTheme.titleSmall),
            TextSpan(text: ' matching ', style: textTheme.bodyMedium),
            TextSpan(text:serviceName, style: textTheme.titleSmall),
          ],
        ),
      ),
    );
  }

  Widget _buildProfessionalsList(
    HomeServicesFindprosController controller,
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
          //  return Text(professional.serviceName);

          return ProfessionalCardWidget(
            professional: professional,
            onTap: () => print("opening a prfessional"),
            //controller.openCategory(professional, context),
            onOpenQuotation: () => controller.openQuestionFlow('01', context),
          );
        },
      ),
    );
  }
}
