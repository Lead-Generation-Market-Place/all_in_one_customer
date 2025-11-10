import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/core/injection_container.dart';
import '../../../../domain/entities/home_services_fetch_professionals_entity.dart';
import '../controllers/single_service_professional_controller.dart';
import '../widgets/single_service_pro_personnel_details_widget.dart';

class SingleServiceProfessionalScreen extends StatefulWidget {
  String proId;
  SingleServiceProfessionalScreen({super.key, required this.proId});

  @override
  State<SingleServiceProfessionalScreen> createState() =>
      _SingleServiceProfessionalScreenState();
}

class _SingleServiceProfessionalScreenState
    extends State<SingleServiceProfessionalScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SingleServiceProfessionalController(homeServicesFindprosUsecase: getIt(),proId: widget.proId),
      child: _buildBody(),
    );
  }
}

class _buildBody extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        trailing: IconButton(
          onPressed: () => print('Share buttn pressed'),
          icon: Icon(Icons.share),
        ),
      ),
      child: Consumer<SingleServiceProfessionalController>(
        builder: (context, controller, child) {
          if (controller.proLoading) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          if (controller.proId.isEmpty) {
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
                    onPressed: controller.retry,
                  ),
                ],
              ),
            );
          }
          return Text("Data is Exists Now Only the Testing is done");
          // SingleServiceProPersonnelDetailsWidget(
          //   professionalsEntity:professionalEntity,
          // );
        },
      ),
    );
  }
}
