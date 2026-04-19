import 'package:investor_app/domain/home/entities/deal_entity.dart';

abstract class DealRepositry {
  Future<List<DealEntity>> fetchDeals();
  Future<List<String>> getIntrestedDealIds();
  Future<void> markInterst(String dealId);
  Future<void> removeInterst(String dealId);
}