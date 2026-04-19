part of 'home_bloc.dart';

abstract class DealState {}

class DealInitialState extends DealState {}

class DealLoadingState extends DealState {}

class DealLoadedState extends DealState {
  final List<DealEntity> allDeals;
  final List<DealEntity> filteredDeals;
  final List<String> intrestedIds;
  final String searchQuery;
  final String? selectedRisk;
  final String? selectedIndustry;
  final double? minRoi;
  final double? maxRoi;

  DealLoadedState({
    required this.allDeals,
    required this.filteredDeals,
    required this.intrestedIds,
    this.searchQuery = '',
    this.selectedRisk,
    this.selectedIndustry,
    this.minRoi,
    this.maxRoi,
  });

  DealLoadedState copyWith({
    List<DealEntity>? allDeals,
    List<DealEntity>? filteredDeals,
    List<String>? intrestedIds,
    String? searchQuery,
    String? selectedRisk,
    String? selectedIndustry,
    double? minRoi,
    double? maxRoi,
    bool clearRisk = false,
    bool clearIndustry = false,
    bool clearRoiRange = false,
  }) {
    return DealLoadedState(
      allDeals: allDeals ?? this.allDeals,
      filteredDeals: filteredDeals ?? this.filteredDeals,
      intrestedIds: intrestedIds ?? this.intrestedIds,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedRisk: clearRisk ? null : (selectedRisk ?? this.selectedRisk),
      selectedIndustry: clearIndustry ? null : (selectedIndustry ?? this.selectedIndustry),
      minRoi: clearRoiRange ? null : (minRoi ?? this.minRoi),
      maxRoi: clearRoiRange ? null : (maxRoi ?? this.maxRoi),
    );
  }
}

class DealErrorState extends DealState {
  final String message;
  DealErrorState(this.message);
}

class IntrestedDealsLoadedState extends DealState {
  final List<DealEntity> deals;
  final List<String> intrestedIds;
  IntrestedDealsLoadedState({required this.deals, required this.intrestedIds});
}