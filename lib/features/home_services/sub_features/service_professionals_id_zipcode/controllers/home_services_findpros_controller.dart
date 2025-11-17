import 'package:flutter/material.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_coordinate_points_entity.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_coordinates_entity.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_fetch_professionals_entity.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_lead_entity.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_location_entity.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_question_entity.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_user_entity.dart';
import 'package:yelpax/features/home_services/domain/usecases/home_services_findpros_usecase.dart';
import 'package:yelpax/features/home_services/domain/usecases/home_services_lead_usecase.dart';
import '../../../../../config/routes/router.dart';

class HomeServicesFindprosController extends ChangeNotifier {
  HomeServicesFindprosUsecase usecase;
  HomeServicesLeadUsecase leadUsecase;

  bool _professionalsLoading = false;
  List<HomeServicesFetchProfessionalsEntity> _professionals = [];
  String _error = "";
  HomeServicesLeadEntity? _leadEntity;

  // Question Flow Data
  Map<String, dynamic> _questionAnswers = {};
  String? _selectedServiceId;
  String? _selectedProfessionalId;
  List<String>? _selectedProfessionalIds;

  // Getters
  bool get professionalsLoading => _professionalsLoading;
  List<HomeServicesFetchProfessionalsEntity> get professionals =>
      _professionals;
  String get error => _error;
  HomeServicesLeadEntity? get leadEntity => _leadEntity;

  // Question Flow Getters
  Map<String, dynamic> get questionAnswers => _questionAnswers;
  String? get selectedServiceId => _selectedServiceId;
  String? get selectedProfessionalId => _selectedProfessionalId;
  List<String>? get selectedProfessionalIds => _selectedProfessionalIds;
  bool get hasQuestionAnswers => _questionAnswers.isNotEmpty;

  HomeServicesFindprosController({
    required this.usecase,
    required this.leadUsecase,
  });


  // ========== PROFESSIONAL METHODS ==========

  Future<void> wrapper(String query, String zipCode) async {
    if (zipCode.isNotEmpty) {
      await getProfessionalByIdAndZip(query, zipCode);
    } else {
      await getProfessionals(query);
    }
  }

  Future<void> getProfessionals(String query) async {
    _professionalsLoading = true;
    _error = "";
    _professionals = [];
    notifyListeners();

    var response = await usecase.call(query);
    response.fold(
      (problem) {
        _error = problem.message;
        _professionalsLoading = false;
        notifyListeners();
      },
      (success) {
        _professionals = success;
        _professionalsLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> getProfessionalByIdAndZip(
    String serviceId,
    String zipCode,
  ) async {
    _professionalsLoading = true;
    notifyListeners();

    final result = await usecase.callByServiceIdZipCode(serviceId, zipCode);
    result.fold(
      (problem) {
        _error = problem.message;
        _professionalsLoading = false;
        notifyListeners();
      },
      (success) {
        _professionals = success;
        _professionalsLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> retry() async {
    print('Retrying....');
  }

  // ========== QUESTION FLOW METHODS ==========

  /// Start question flow and store professional selection
  Future<void> openQuestionFlow(
    List<HomeServicesQuestionEntity> questions,
    BuildContext context, {
    required String serviceId,
    String? professionalId,
    List<String>? professionalIds,
  }) async {
    // Store the service and professional selection
    _selectedServiceId = serviceId;
    _selectedProfessionalId = professionalId;
    _selectedProfessionalIds = professionalIds;

    // Clear previous answers
    _questionAnswers = {};

    notifyListeners();

    Navigator.pushNamed(
      context,
      AppRouter.questionFlowScreen,
      arguments: questions,
    );
  }

  /// Save answers from question flow
  void saveQuestionAnswers(Map<String, dynamic> answers) {
    _questionAnswers = Map<String, dynamic>.from(answers);
    notifyListeners();
    print('✅ Saved ${_questionAnswers.length} question answers');
  }

  /// Clear question flow data
  void clearQuestionFlowData() {
    _questionAnswers = {};
    _selectedServiceId = null;
    _selectedProfessionalId = null;
    _selectedProfessionalIds = null;
    notifyListeners();
    print('🧹 Cleared question flow data');
  }

  // ========== LEAD CREATION METHODS ==========

  /// Create lead using question flow answers
  Future<void> createLeadFromQuestionFlow({
    required HomeServicesUserEntity userInfo,
    required HomeServicesLocationEntity userLocation,
    String sendOption = 'selected',
  }) async {
    if (_selectedServiceId == null) {
      _error = 'No service selected';
      notifyListeners();
      return;
    }

    if (_questionAnswers.isEmpty) {
      _error = 'No question answers available';
      notifyListeners();
      return;
    }

    _professionalsLoading = true;
    _error = '';
    notifyListeners();

    // Determine which professionals to send to
    List<String>? professionalIds;
    String? professionalId;

    if (sendOption == 'top5' && _selectedProfessionalIds != null) {
      professionalIds = _selectedProfessionalIds;
    } else if (sendOption == 'selected' && _selectedProfessionalId != null) {
      professionalId = _selectedProfessionalId;
      professionalIds = [_selectedProfessionalId!];
    }

    final params = CreateLeadParams(
      serviceId: _selectedServiceId!,
      responses: _questionAnswers,
      userInfo: userInfo,
      userLocation: userLocation,
      sendOption: sendOption,
      professionalId: professionalId,
      professionalIds: professionalIds,
    );

    final result = await leadUsecase(params);

    result.fold(
      (failure) {
        _error = failure.message;
        _professionalsLoading = false;
        notifyListeners();
        print("Error On Creating Lead 👌😒😒");
      },
      (lead) {
        _leadEntity = lead;
        _professionalsLoading = false;
        _error = '';

        // Clear question flow data after successful creation
        clearQuestionFlowData();
        notifyListeners();

        print('🎉 Lead created successfully: ${lead.id}');
      },
    );
  }

  /// Quick method to create lead with basic user info
  Future<void> createQuickLead({
    required String userEmail,
    required String userPhone,
    required String description,
  }) async {
    final userInfo = HomeServicesUserEntity(
      id: '',
      email: userEmail,
      phone: userPhone,
      description: description,
      username: '',
    );

    final userLocation = HomeServicesLocationEntity(
      addressLine: 'User Address',
      id: '',
      type: '',
      country: '',
      state: '',
      city: '',
      zipCode: [],
      createdAt: '',
      updatedAt: '',
      coordinates: HomeServicesCoordinatesEntity(
        type: '',
        geoPoints: HomeServicesCoordinatePointsEntity(
          longitude: 0.0,
          latitude: 0.0,
        ),
      ), // You can get from GPS
    );

    await createLeadFromQuestionFlow(
      userInfo: userInfo,
      userLocation: userLocation,
      sendOption: _selectedProfessionalId != null ? 'selected' : 'top5',
    );
  }

  // ========== NAVIGATION METHODS ==========

  Future<void> openCategory(Map categoryDetails, BuildContext context) async {
    print(categoryDetails);
    Navigator.pushNamed(
      context,
      AppRouter.singleServiceProfessionalScreen,
      arguments: categoryDetails,
    );
  }

  Future<void> openProfessionalDetails(BuildContext context, int index) async {
    Navigator.pushNamed(
      context,
      AppRouter.singleServiceProfessionalScreen,
      arguments: _professionals[index].professional.id,
    );
  }

  /// Navigate to lead creation screen with collected data
  Future<void> navigateToLeadCreation(BuildContext context) async {
    if (_selectedServiceId == null || _questionAnswers.isEmpty) {
      _error = 'Please complete the question flow first';
      notifyListeners();
      return;
    }

    // Navigator.pushNamed(
    //   context,
    //   AppRouter.createLeadScreen,
    //   arguments: {
    //     'serviceId': _selectedServiceId,
    //     'answers': _questionAnswers,
    //     'professionalId': _selectedProfessionalId,
    //     'professionalIds': _selectedProfessionalIds,
    //   },
    // );
  }

  @override
  void dispose() {
    _professionals = [];
    _questionAnswers = {};
    _selectedServiceId = null;
    _selectedProfessionalId = null;
    _selectedProfessionalIds = null;
    super.dispose();
  }
}
