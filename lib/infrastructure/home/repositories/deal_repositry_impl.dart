import 'dart:convert';
import 'package:investor_app/domain/home/entities/deal_entity.dart';
import 'package:investor_app/domain/home/repositories/deal_repositry.dart';
import 'package:investor_app/infrastructure/home/dtos/mock_deal_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DealRepositryImpl implements DealRepositry {
  final MockDealDataSource _dataSource = MockDealDataSource();
  static const String _interestKey = 'intrested_deals';

  @override
  Future<List<DealEntity>> fetchDeals() async {
    final deals = await _dataSource.getDeals();
    return deals;
  }

  @override
  Future<List<String>> getIntrestedDealIds() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_interestKey);
    if (stored == null) return [];
    final List<dynamic> decoded = jsonDecode(stored);
    return decoded.cast<String>();
  }

  @override
  Future<void> markInterst(String dealId) async {
    final prefs = await SharedPreferences.getInstance();
    final current = await getIntrestedDealIds();
    if (!current.contains(dealId)) {
      current.add(dealId);
      await prefs.setString(_interestKey, jsonEncode(current));
    }
  }

  @override
  Future<void> removeInterst(String dealId) async {
    final prefs = await SharedPreferences.getInstance();
    final current = await getIntrestedDealIds();
    current.remove(dealId);
    await prefs.setString(_interestKey, jsonEncode(current));
  }
}