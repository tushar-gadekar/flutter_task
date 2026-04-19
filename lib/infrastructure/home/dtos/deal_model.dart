
import 'package:investor_app/domain/home/entities/deal_entity.dart';

class DealModel extends DealEntity {
  const DealModel({
    required super.id,
    required super.companyName,
    required super.industry,
    required super.investmentRequired,
    required super.expectedRoi,
    required super.riskLevel,
    required super.status,
    required super.companyOverview,
    required super.financialHighlights,
    required super.riskExplanation,
    required super.roiProjection,
  });

  factory DealModel.fromJson(Map<String, dynamic> json) {
    return DealModel(
      id: json['id'],
      companyName: json['company_name'],
      industry: json['industry'],
      investmentRequired: (json['investment_required'] as num).toDouble(),
      expectedRoi: (json['expected_roi'] as num).toDouble(),
      riskLevel: json['risk_level'],
      status: json['status'],
      companyOverview: json['company_overview'],
      financialHighlights: json['financial_highlights'],
      riskExplanation: json['risk_explanation'],
      roiProjection: List<double>.from(
        (json['roi_projection'] as List).map((e) => (e as num).toDouble()),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_name': companyName,
      'industry': industry,
      'investment_required': investmentRequired,
      'expected_roi': expectedRoi,
      'risk_level': riskLevel,
      'status': status,
      'company_overview': companyOverview,
      'financial_highlights': financialHighlights,
      'risk_explanation': riskExplanation,
      'roi_projection': roiProjection,
    };
  }
}