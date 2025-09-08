import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/professional.dart';
import '../controllers/home_services_controller.dart';
import '../controllers/search_professional_controller.dart';
import '../../search_professional_di.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_shimmer.dart';
import '../../../../shared/widgets/custom_input.dart';

class SearchProfessionalScreen extends StatelessWidget {
  const SearchProfessionalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => searchProfessionalController(),
      child: const _searchProBody(),
    );
  }
}

class _searchProBody extends StatefulWidget {
  const _searchProBody({super.key});

  @override
  State<_searchProBody> createState() => __searchProBodyState();
}

class __searchProBodyState extends State<_searchProBody> {
  late TextEditingController _searchController;
  late TextEditingController _zipController;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _searchController = TextEditingController();
    _zipController = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _zipController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void onCompleteCategory(String name) {
    _searchController.text = name;

    var _searchProController = Provider.of<SearchProfessionalController>(
      context,
      listen: false,
    );
    _searchProController.clearResult();
  }

  void onClear() {
    var _searchProController = Provider.of<SearchProfessionalController>(
      context,
      listen: false,
    );
    _searchProController.clearResult();
    _searchController.clear();
  }

  void onChanged(String value) {
    var _searchProController = Provider.of<SearchProfessionalController>(
      context,
      listen: false,
    );
    _searchProController.search(value);
  }

  void onSearch() {
    var controller = Provider.of<HomeServicesController>(
      context,
      listen: false,
    );
    if (formKey.currentState!.validate()) {
      controller.openCategory({'name': _searchController.text}, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomInput(
            onChanged: (value) => onChanged(value),
            validator: (p0) {
              if (p0 == null || p0.isEmpty) {
                return 'Enter Service';
              }
              return null;
            },
            hint: 'Which Service do you need',
            icon: Icons.search,
            controller: _searchController,
            suffixIcon: GestureDetector(
              onTap: onClear,
              child: Icon(Icons.clear),
            ),
          ),
          SizedBox(height: 10),
          CustomInput(
            validator: (p0) {
              if (p0 == null || p0.isEmpty) return 'Enter Zip Code';

              return null;
            },
            hint: 'Zip Code',
            icon: Icons.location_on_outlined,
            controller: _zipController,
            suffixIcon: GestureDetector(
              onTap: () {
                _zipController.clear();
              },
              child: Icon(Icons.clear),
            ),
          ),
          SizedBox(height: 20),
          CustomButton(
            type: CustomButtonType.primary,

            text: 'Search',

            onPressed: onSearch,
          ),
          SizedBox(height: 10),
          Consumer<SearchProfessionalController>(
            builder: (context, value, child) {
              if (value.isLoading) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomShimmer(
                    layoutType: ShimmerLayoutType.list,
                    itemCount: 2,
                  ),
                );
              }
              if (value.errorMessage.isNotEmpty) {
                return Text(value.errorMessage);
              }
              if (value.professionals.isEmpty) {
                return SizedBox.shrink();
              }
              return Container(
                height: 150,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: value.professionals.length,
                  itemBuilder: (context, index) =>
                      _buildSearchFieldData(value.professionals[index]),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchFieldData(Professional pro) {
    return Center(
      child: ListTile(
        onTap: () => onCompleteCategory(pro.name),
        leading: CircleAvatar(child: Text(pro.id)),
        title: Text(pro.name),
      ),
    );
  }
}
