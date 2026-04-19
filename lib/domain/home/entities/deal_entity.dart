class DealEntity {
  final String id;
  final String companyName;
  final String industry;
  final double investmentRequired;
  final double expectedRoi;
  final String riskLevel;
  final String status;
  final String companyOverview;
  final String financialHighlights;
  final String riskExplanation;
  final List<double> roiProjection;

  const DealEntity({
    required this.id,
    required this.companyName,
    required this.industry,
    required this.investmentRequired,
    required this.expectedRoi,
    required this.riskLevel,
    required this.status,
    required this.companyOverview,
    required this.financialHighlights,
    required this.riskExplanation,
    required this.roiProjection,
  });
}