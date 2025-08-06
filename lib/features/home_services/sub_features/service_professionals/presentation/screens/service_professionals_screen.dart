import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/features/home_services/sub_features/service_professionals/presentation/controllers/service_professionals_controller.dart';

class ServiceProfessionalsScreen extends StatefulWidget {
  var serviceDetails;
  ServiceProfessionalsScreen({super.key, required this.serviceDetails});

  @override
  State<ServiceProfessionalsScreen> createState() =>
      _ServiceProfessionalsScreenState();
}

class _ServiceProfessionalsScreenState
    extends State<ServiceProfessionalsScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return ServiceProfessionalsController(widget.serviceDetails);
      },
      child: _ServiceProfessionalsView(),
    );
  }
}

class _ServiceProfessionalsView extends StatelessWidget {
  const _ServiceProfessionalsView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ServiceProfessionalsController>();

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Service Professionals'),
      ),
      child: SafeArea(
        child: Center(
          child: Builder(
            builder: (_) {
              if (controller.professionalsLoading) {
                return const CupertinoActivityIndicator();
              }

              if (controller.professionals.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("No professionals found."),
                    const SizedBox(height: 12),
                    CupertinoButton(
                      child: const Text("Retry"),
                      onPressed: controller.retry,
                    ),
                  ],
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: controller.professionals.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final item = controller.professionals[index];
                  return ListTile(
                    title: Text(item['name']),
                    subtitle: Text(
                      "Rating: ${item['ratings']} | Hired: ${item['timesHired']}x",
                    ),
                    trailing: Text(item['estimatedPrice']),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
