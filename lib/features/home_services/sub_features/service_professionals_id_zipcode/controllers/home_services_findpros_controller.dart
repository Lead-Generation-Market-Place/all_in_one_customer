import 'package:flutter/material.dart';
import 'package:yelpax/config/routes/router.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_fetch_professionals_entity.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_lead_entity.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_location_entity.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_question_entity.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_user_entity.dart';
import 'package:yelpax/features/home_services/domain/usecases/home_services_findpros_usecase.dart';
import 'package:yelpax/features/home_services/domain/usecases/home_services_lead_usecase.dart';

import '../../../domain/entities/home_services_coordinate_points_entity.dart';
import '../../../domain/entities/home_services_coordinates_entity.dart';

class HomeServicesFindprosController extends ChangeNotifier {
  final HomeServicesFindprosUsecase _usecase;
  final HomeServicesLeadUsecase _leadUsecase;

  // State
  bool _professionalsLoading = false;
  List<HomeServicesFetchProfessionalsEntity> _professionals = [];
  String _error = "";
  HomeServicesLeadEntity? _leadEntity;

  // Question Flow State
  Map<String, dynamic> _questionAnswers = {};
  String? _selectedServiceId;
  String? _selectedProfessionalId;
  List<String>? _selectedProfessionalIds;

  // Getters
  bool get professionalsLoading => _professionalsLoading;
  List<HomeServicesFetchProfessionalsEntity> get professionals => _professionals;
  String get error => _error;
  HomeServicesLeadEntity? get leadEntity => _leadEntity;
  Map<String, dynamic> get questionAnswers => _questionAnswers;
  String? get selectedServiceId => _selectedServiceId;
  String? get selectedProfessionalId => _selectedProfessionalId;
  List<String>? get selectedProfessionalIds => _selectedProfessionalIds;
  bool get hasQuestionAnswers => _questionAnswers.isNotEmpty;

  HomeServicesFindprosController({
    required HomeServicesFindprosUsecase usecase,
    required HomeServicesLeadUsecase leadUsecase,
  })  : _usecase = usecase,
        _leadUsecase = leadUsecase;

  // ========== PUBLIC METHODS ==========

  /// Main entry point for loading professionals
  Future<void> loadProfessionals({required String serviceId, String zipCode = ''}) async {
    if (zipCode.isNotEmpty) {
      await _getProfessionalsByZipCode(serviceId, zipCode);
    } else {
      await _getProfessionalsByService(serviceId);
    }
  }
List<String> _getTop5ProfessionalIds() {
  // Example: Get IDs of first 5 professionals, or implement your own sorting logic
  return _professionals
      .take(5)
      .map((pro) => pro.professional.id)
      .toList();
}
  /// Start question flow for a professional
  Future<void> startQuestionFlow(List<HomeServicesQuestionEntity> questions, {
    //required List<HomeServicesQuestionEntity> questions,
    required BuildContext context,
    required String serviceId,
    String? professionalId,
  }) async {
    _logQuestionFlowStart(serviceId, professionalId, questions.length);
    
    _storeQuestionFlowData(serviceId, professionalId);
    Navigator.pushNamed(context, AppRouter.questionFlowScreen, arguments: questions);
  }

  /// Save answers from completed question flow
  void saveQuestionAnswers(Map<String, dynamic> answers) {
    _questionAnswers = Map<String, dynamic>.from(answers);
    notifyListeners();
    _logQuestionAnswersSaved(answers.length);
  }

  /// Create lead from collected question flow data
  Future<void> createLeadFromQuestionFlow({
    required HomeServicesUserEntity userInfo,
    required HomeServicesLocationEntity userLocation,
    String sendOption = 'selected',
  }) async {
    if (!_validateLeadCreationData()) return;

    _setLoadingState(true);
    
    final params = _buildLeadParams(sendOption, userInfo, userLocation);
    final result = await _leadUsecase(params);

    result.fold(
      (failure) => _handleLeadCreationFailure(failure.message),
      (lead) => _handleLeadCreationSuccess(lead),
    );
  }

  /// Quick lead creation with basic user info
  Future<void> createQuickLead({
    required String userEmail,
    required String userPhone,
    required String description,
    required String sendOption
  }) async {
    _logQuickLeadCreation();
    
    if (!_validateLeadCreationData()) return;

    final userInfo = _buildUserInfo(userEmail, userPhone, description);
    final userLocation = _buildDefaultLocation();
    
    await createLeadFromQuestionFlow(
      userInfo: userInfo,
      userLocation: userLocation,
      sendOption: sendOption,
    );
  }

  /// Retry loading professionals
  Future<void> retry() async {
    if (_selectedServiceId != null) {
      await loadProfessionals(serviceId: _selectedServiceId!);
    }
  }

  /// Navigate to professional details
  void navigateToProfessionalDetails(BuildContext context, int index) {
    Navigator.pushNamed(
      context,
      AppRouter.singleServiceProfessionalScreen,
      arguments: _professionals[index].professional.id,
    );
  }

  /// Clear question flow data (useful for resetting state)
  void clearQuestionFlowData() {
    _questionAnswers = {};
    _selectedServiceId = null;
    _selectedProfessionalId = null;
    _selectedProfessionalIds = null;
    notifyListeners();
    _logQuestionFlowCleared();
  }

  // ========== PRIVATE METHODS ==========

  // Professional Loading
  Future<void> _getProfessionalsByService(String serviceId) async {
    _setLoadingState(true, clearError: true, clearProfessionals: true);
    final response = await _usecase.call(serviceId);
    response.fold(
      (problem) => _handleProfessionalsError(problem.message),
      (success) => _handleProfessionalsSuccess(success),
    );
  }

  Future<void> _getProfessionalsByZipCode(String serviceId, String zipCode) async {
    _setLoadingState(true);
    
    final result = await _usecase.callByServiceIdZipCode(serviceId, zipCode);
    result.fold(
      (problem) => _handleProfessionalsError(problem.message),
      (success) => _handleProfessionalsSuccess(success),
    );
  }

  // State Management
  void _setLoadingState(bool loading, {bool clearError = false, bool clearProfessionals = false}) {
    _professionalsLoading = loading;
    if (clearError) _error = "";
    if (clearProfessionals) _professionals = [];
    notifyListeners();
  }

  void _handleProfessionalsSuccess(List<HomeServicesFetchProfessionalsEntity> professionals) {
    _professionals = professionals;
    _setLoadingState(false);
  }

  void _handleProfessionalsError(String error) {
    _error = error;
    _setLoadingState(false);
  }

  // Question Flow Management
  void _storeQuestionFlowData(String serviceId, String? professionalId) {
    _selectedServiceId = serviceId;
    _selectedProfessionalId = professionalId;
    _selectedProfessionalIds = professionalId != null ? [professionalId] : null;
    _questionAnswers = {};
    notifyListeners();
  }

  bool _validateLeadCreationData() {
    if (_selectedServiceId == null) {
      _error = 'No service selected';
      notifyListeners();
      return false;
    }

    if (_questionAnswers.isEmpty) {
      _error = 'No question answers available';
      notifyListeners();
      return false;
    }

    return true;
  }

  // Lead Creation
  CreateLeadParams _buildLeadParams(
    String sendOption,
    HomeServicesUserEntity userInfo,
    HomeServicesLocationEntity userLocation,
  ) {
    List<String>? professionalIds;
    String? professionalId;

    if (sendOption == 'top5') {
    professionalIds = _getTop5ProfessionalIds();
    print('📋 Top 5 Professional IDs: $professionalIds');
  } else if (sendOption == 'selected' && _selectedProfessionalId != null) {
    professionalId = _selectedProfessionalId;
    professionalIds = [_selectedProfessionalId!];
    print('📋 Selected Professional ID: $professionalId');
  }

    return CreateLeadParams(
      serviceId: _selectedServiceId!,
      responses: _questionAnswers,
      userInfo: userInfo,
      userLocation: userLocation,
      sendOption: sendOption,
      professionalId: professionalId,
      professionalIds: professionalIds,
    );
  }

  HomeServicesUserEntity _buildUserInfo(String email, String phone, String description) {
    return HomeServicesUserEntity(
      id: '',
      email: email,
      phone: phone,
      description: description,
      username: '',
    );
  }

  HomeServicesLocationEntity _buildDefaultLocation() {
    return HomeServicesLocationEntity(
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
      ),
    );
  }

  void _handleLeadCreationFailure(String error) {
    _error = error;
    _setLoadingState(false);
    _logLeadCreationError(error);
  }

  void _handleLeadCreationSuccess(HomeServicesLeadEntity lead) {
    _leadEntity = lead;
    _setLoadingState(false);
    clearQuestionFlowData();
    _logLeadCreationSuccess(lead.id);
  }

  // Logging
  void _logQuestionFlowStart(String serviceId, String? professionalId, int questionCount) {
    print('🚀 OPENING QUESTION FLOW');
    print('📦 Service ID: $serviceId');
    print('📦 Professional ID: $professionalId');
    print('📦 Questions count: $questionCount');
  }

  void _logQuestionAnswersSaved(int answerCount) {
    print('✅ Saved $answerCount question answers');
  }

  void _logQuestionFlowCleared() {
    print('🧹 Cleared question flow data');
  }

  void _logQuickLeadCreation() {
    print('🚀 CREATE QUICK LEAD CALLED');
    print('🔍 _selectedServiceId: $_selectedServiceId');
    print('🔍 _selectedProfessionalId: $_selectedProfessionalId');
    print('🔍 _selectedProfessionalIds: $_selectedProfessionalIds');
    print('🔍 _questionAnswers: $_questionAnswers');
  }

  void _logLeadCreationError(String error) {
    print('❌ Lead creation failed: $error');
  }

  void _logLeadCreationSuccess(String leadId) {
    print('🎉 Lead created successfully: $leadId');
  }
}