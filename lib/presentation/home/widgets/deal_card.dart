import 'package:flutter/material.dart';
import 'package:investor_app/domain/home/entities/deal_entity.dart';
import 'package:investor_app/presentation/core/theme/app_theme.dart';
import 'package:investor_app/presentation/core/utils/app_utils.dart';

class DealCard extends StatelessWidget {
  final DealEntity deal;
  final bool isIntrested;
  final VoidCallback onTap;
  final VoidCallback onIntrestToggle;

  const DealCard({
    super.key,
    required this.deal,
    required this.isIntrested,
    required this.onTap,
    required this.onIntrestToggle,
  });

  @override
  Widget build(BuildContext context) {
    final riskColor = AppUtils.getRiskColor(deal.riskLevel);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        deal.companyName[0],
                        style: const TextStyle(
                          color: AppColors.accent,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          deal.companyName,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            _chip(deal.industry, AppColors.accent.withOpacity(0.2), AppColors.accent),
                            const SizedBox(width: 6),
                            _chip(
                              deal.status,
                              deal.status == 'Open'
                                  ? AppColors.riskLow.withOpacity(0.15)
                                  : AppColors.riskHigh.withOpacity(0.15),
                              deal.status == 'Open' ? AppColors.riskLow : AppColors.riskHigh,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: AppColors.divider, height: 1),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  _statItem('Investment', AppUtils.formatInr(deal.investmentRequired)),
                  _verticalDivider(),
                  _statItem('ROI', '${deal.expectedRoi}%'),
                  _verticalDivider(),
                  _statItem(
                    'Risk',
                    deal.riskLevel,
                    valueColor: riskColor,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tap to view details →',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  GestureDetector(
                    onTap: onIntrestToggle,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isIntrested
                            ? AppColors.accent.withOpacity(0.2)
                            : Colors.transparent,
                        border: Border.all(
                          color: isIntrested ? AppColors.accent : AppColors.textSecondary,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isIntrested ? Icons.bookmark : Icons.bookmark_border,
                            size: 14,
                            color: isIntrested ? AppColors.accent : AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            isIntrested ? 'Interested' : 'Interest',
                            style: TextStyle(
                              fontSize: 12,
                              color: isIntrested ? AppColors.accent : AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(String label, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(color: textColor, fontSize: 11, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _statItem(String label, String value, {Color? valueColor}) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? AppColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(width: 1, height: 32, color: AppColors.divider);
  }
}