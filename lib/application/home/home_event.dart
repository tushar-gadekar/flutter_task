part of 'home_bloc.dart';

abstract class DealEvent {}

class LoadDealsEvent extends DealEvent {}

class SearchDealsEvent extends DealEvent {
  final String query;
  SearchDealsEvent(this.query);
}

class FilterDealsEvent extends DealEvent {
  final String? riskLevel;
  final String? industry;
  final double? minRoi;
  final double? maxRoi;

  FilterDealsEvent({
    this.riskLevel,
    this.industry,
    this.minRoi,
    this.maxRoi,
  });
}

class MarkIntrestEvent extends DealEvent {
  final DealEntity deal;
  MarkIntrestEvent(this.deal);
}

class RemoveIntrestEvent extends DealEvent {
  final String dealId;
  RemoveIntrestEvent(this.dealId);
}

class LoadIntrestedDealsEvent extends DealEvent {}

class ClearFiltersEvent extends DealEvent {}