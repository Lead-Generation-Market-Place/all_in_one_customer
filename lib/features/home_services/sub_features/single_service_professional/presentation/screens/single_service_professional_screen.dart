import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/features/home_services/sub_features/single_service_professional/presentation/controllers/single_service_professional_controller.dart';

class SingleServiceProfessionalScreen extends StatefulWidget {
  const SingleServiceProfessionalScreen({super.key});

  @override
  State<SingleServiceProfessionalScreen> createState() =>
      _SingleServiceProfessionalScreenState();
}

class _SingleServiceProfessionalScreenState
    extends State<SingleServiceProfessionalScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SingleServiceProfessionalController(),
      child: _buildBody(),
    );
  }
}

class _buildBody extends StatelessWidget {
  const _buildBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        trailing: IconButton(
          onPressed: () => print('Share buttn pressed'),
          icon: Icon(Icons.share),
        ),
      ),
      child: Placeholder(),
    );
  }
}
