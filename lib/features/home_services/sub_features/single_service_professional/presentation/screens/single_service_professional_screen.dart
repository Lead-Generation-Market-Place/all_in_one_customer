import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/features/home_services/sub_features/single_service_professional/presentation/controllers/single_service_professional_controller.dart';
import 'package:yelpax/features/home_services/sub_features/single_service_professional/presentation/widgets/single_service_pro_personnel_details_widget.dart';

class SingleServiceProfessionalScreen extends StatefulWidget {
  var proDetails;
  SingleServiceProfessionalScreen({super.key, required this.proDetails});

  @override
  State<SingleServiceProfessionalScreen> createState() =>
      _SingleServiceProfessionalScreenState();
}

class _SingleServiceProfessionalScreenState
    extends State<SingleServiceProfessionalScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SingleServiceProfessionalController(widget.proDetails),
      child: _buildBody(),
    );
  }
}

class _buildBody extends StatelessWidget {
  const _buildBody();

  @override
  Widget build(BuildContext context) {
    SingleServiceProfessionalController _controller = context
        .watch<SingleServiceProfessionalController>();
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        trailing: IconButton(
          onPressed: () => print('Share buttn pressed'),
          icon: Icon(Icons.share),
        ),
      ),
      child: Consumer<SingleServiceProfessionalController>(
        builder: (context, value, child) {
          if (value.proLoading) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          if (value.proCompleteDetails.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No professionals found",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  CupertinoButton.filled(
                    child: const Text("Retry"),
                    onPressed: value.retry,
                  ),
                ],
              ),
            );
          }
          return SingleServiceProPersonnelDetailsWidget(
            proCompleteDetails: _controller.proCompleteDetails,
            proDetails: _controller.proDetails,
          );
        },
      ),
    );
  }
}
