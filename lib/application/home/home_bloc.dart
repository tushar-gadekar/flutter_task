import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investor_app/domain/home/entities/deal_entity.dart';
import 'package:investor_app/domain/home/repositories/deal_repositry.dart';
part 'home_event.dart';
part 'home_state.dart';

class DealBloc extends Bloc<DealEvent, DealState> {
  final DealRepositry _repositry;

  DealBloc(this._repositry) : super(DealInitialState()) {
    on<LoadDealsEvent>(_onLoadDeals);
    on<SearchDealsEvent>(_onSearch);
    on<FilterDealsEvent>(_onFilter);
    on<MarkIntrestEvent>(_onMarkInterst);
    on<RemoveIntrestEvent>(_onRemoveInterst);
    on<LoadIntrestedDealsEvent>(_onLoadIntrested);
    on<ClearFiltersEvent>(_onClearFilters);
  }

  Future<void> _onLoadDeals(LoadDealsEvent event, Emitter<DealState> emit) async {
    emit(DealLoadingState());
    try {
      final deals = await _repositry.fetchDeals();
      final intrestedIds = await _repositry.getIntrestedDealIds();
      emit(DealLoadedState(
        allDeals: deals,
        filteredDeals: deals,
        intrestedIds: intrestedIds,
      ));
    } catch (e) {
      emit(DealErrorState('Somthing went wrong. Please try again.'));
    }
  }

  void _onSearch(SearchDealsEvent event, Emitter<DealState> emit) {
    if (state is! DealLoadedState) return;
    final current = state as DealLoadedState;
    final filtered = _applyFilters(
      current.allDeals,
      query: event.query,
      risk: current.selectedRisk,
      industry: current.selectedIndustry,
      minRoi: current.minRoi,
      maxRoi: current.maxRoi,
    );
    emit(current.copyWith(filteredDeals: filtered, searchQuery: event.query));
  }

  void _onFilter(FilterDealsEvent event, Emitter<DealState> emit) {
    if (state is! DealLoadedState) return;
    final current = state as DealLoadedState;
    final filtered = _applyFilters(
      current.allDeals,
      query: current.searchQuery,
      risk: event.riskLevel,
      industry: event.industry,
      minRoi: event.minRoi,
      maxRoi: event.maxRoi,
    );
    emit(DealLoadedState(
      allDeals: current.allDeals,
      filteredDeals: filtered,
      intrestedIds: current.intrestedIds,
      searchQuery: current.searchQuery,
      selectedRisk: event.riskLevel,
      selectedIndustry: event.industry,
      minRoi: event.minRoi,
      maxRoi: event.maxRoi,
    ));
  }

  void _onClearFilters(ClearFiltersEvent event, Emitter<DealState> emit) {
    if (state is! DealLoadedState) return;
    final current = state as DealLoadedState;
    emit(current.copyWith(
      filteredDeals: current.allDeals,
      searchQuery: '',
      clearRisk: true,
      clearIndustry: true,
      clearRoiRange: true,
    ));
  }

  Future<void> _onMarkInterst(MarkIntrestEvent event, Emitter<DealState> emit) async {
    await _repositry.markInterst(event.deal.id);
    final updatedIds = await _repositry.getIntrestedDealIds();
    if (state is DealLoadedState) {
      final current = state as DealLoadedState;
      emit(current.copyWith(intrestedIds: updatedIds));
    } else if (state is IntrestedDealsLoadedState) {
      final current = state as IntrestedDealsLoadedState;
      emit(IntrestedDealsLoadedState(
        deals: current.deals,
        intrestedIds: updatedIds,
      ));
    }
  }

  Future<void> _onRemoveInterst(RemoveIntrestEvent event, Emitter<DealState> emit) async {
    await _repositry.removeInterst(event.dealId);
    final updatedIds = await _repositry.getIntrestedDealIds();
    if (state is IntrestedDealsLoadedState) {
      final current = state as IntrestedDealsLoadedState;
      final updatedDeals = current.deals.where((d) => updatedIds.contains(d.id)).toList();
      emit(IntrestedDealsLoadedState(deals: updatedDeals, intrestedIds: updatedIds));
    } else if (state is DealLoadedState) {
      final current = state as DealLoadedState;
      emit(current.copyWith(intrestedIds: updatedIds));
    }
  }

  Future<void> _onLoadIntrested(LoadIntrestedDealsEvent event, Emitter<DealState> emit) async {
    emit(DealLoadingState());
    try {
      final allDeals = await _repositry.fetchDeals();
      final intrestedIds = await _repositry.getIntrestedDealIds();
      final intrestedDeals = allDeals.where((d) => intrestedIds.contains(d.id)).toList();
      emit(IntrestedDealsLoadedState(deals: intrestedDeals, intrestedIds: intrestedIds));
    } catch (e) {
      emit(DealErrorState('Failed to load your interests.'));
    }
  }

  List<DealEntity> _applyFilters(
      List<DealEntity> deals, {
        String query = '',
        String? risk,
        String? industry,
        double? minRoi,
        double? maxRoi,
      }) {
    return deals.where((deal) {
      final matchesQuery =
          query.isEmpty || deal.companyName.toLowerCase().contains(query.toLowerCase());
      final matchesRisk = risk == null || risk.isEmpty || deal.riskLevel == risk;
      final matchesIndustry =
          industry == null || industry.isEmpty || deal.industry == industry;
      final matchesMinRoi = minRoi == null || deal.expectedRoi >= minRoi;
      final matchesMaxRoi = maxRoi == null || deal.expectedRoi <= maxRoi;
      return matchesQuery && matchesRisk && matchesIndustry && matchesMinRoi && matchesMaxRoi;
    }).toList();
  }
}