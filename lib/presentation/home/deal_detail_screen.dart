import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investor_app/application/home/home_bloc.dart';
import 'package:investor_app/domain/home/entities/deal_entity.dart';
import 'package:investor_app/presentation/core/theme/app_theme.dart';
import 'package:investor_app/presentation/core/utils/app_utils.dart';

class DealDetailScreen extends StatelessWidget {
  final DealEntity deal;
  final bool isIntrested;

  const DealDetailScreen({super.key, required this.deal, required this.isIntrested});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DealBloc, DealState>(
      builder: (context, state) {
        bool currentIntrested = false;
        if (state is DealLoadedState) {
          currentIntrested = state.intrestedIds.contains(deal.id);
        } else if (state is IntrestedDealsLoadedState) {
          currentIntrested = state.intrestedIds.contains(deal.id);
        } else {
          currentIntrested = isIntrested;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(deal.companyName),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, size: 18),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.cardBg,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: AppColors.accent.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                deal.companyName[0],
                                style: const TextStyle(
                                  color: AppColors.accent,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                deal.companyName,
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  _chip(deal.industry, AppColors.accent.withOpacity(0.15), AppColors.accent),
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
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          _keyVal('Investment', AppUtils.formatInr(deal.investmentRequired)),
                          _keyVal('ROI', '${deal.expectedRoi}%'),
                          _keyVal('Risk', deal.riskLevel,
                              color: AppUtils.getRiskColor(deal.riskLevel)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _sectionTitle('Company Overview'),
                _infoCard(deal.companyOverview),
                const SizedBox(height: 16),
                _sectionTitle('Financial Highlights'),
                _financialsCard(deal.financialHighlights),
                const SizedBox(height: 16),
                _sectionTitle('ROI Projection (12 months)'),
                _roiChart(deal.roiProjection),
                const SizedBox(height: 16),
                _sectionTitle('Risk Analysis'),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppUtils.getRiskColor(deal.riskLevel).withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppUtils.getRiskColor(deal.riskLevel).withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.warning_amber_rounded,
                          color: AppUtils.getRiskColor(deal.riskLevel), size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          deal.riskExplanation,
                          style: const TextStyle(
                              color: AppColors.textSecondary, height: 1.5),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                SizedBox(
                  width: double.infinity,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: currentIntrested
                        ? OutlinedButton.icon(
                      key: const ValueKey('remove'),
                      onPressed: () {
                        context.read<DealBloc>().add(RemoveIntrestEvent(deal.id));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Interest removed'),
                            backgroundColor: AppColors.riskMedium,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.accent,
                        side: const BorderSide(color: AppColors.accent),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: const Icon(Icons.bookmark, size: 18),
                      ),
                      label: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: const Text('Already Interested',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    )
                        : ElevatedButton.icon(
                      key: const ValueKey('add'),
                      onPressed: deal.status == 'Closed'
                          ? null
                          : () {
                        context.read<DealBloc>().add(MarkIntrestEvent(deal));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                const Icon(Icons.check_circle,
                                    color: AppColors.primary, size: 16),
                                const SizedBox(width: 8),
                                Text('Interest registered for ${deal.companyName}!'),
                              ],
                            ),
                            backgroundColor: AppColors.accent,
                            duration: const Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        );
                      },
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: const Icon(Icons.bookmark_border, size: 18),
                      ),
                      label: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Text(deal.status == 'Closed'
                            ? 'Deal Closed'
                            : "I'm Interested"),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _infoCard(String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Text(
        text,
        style: const TextStyle(color: AppColors.textSecondary, height: 1.6),
      ),
    );
  }

  Widget _financialsCard(String text) {
    final parts = text.split('|');
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: parts.map((p) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.inputFill,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.divider),
            ),
            child: Text(
              p.trim(),
              style: const TextStyle(color: AppColors.textPrimary, fontSize: 12),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _roiChart(List<double> data) {
    final maxVal = data.reduce((a, b) => a > b ? a : b);
    final months = ['J', 'F', 'M', 'A', 'M', 'J', 'J', 'A', 'S', 'O', 'N', 'D'];

    return Container(
      height: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(data.length, (i) {
          final heightRatio = data[i] / maxVal;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 400 + (i * 50)),
                    curve: Curves.easeOut,
                    height: 95 * heightRatio,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          AppColors.accent,
                          AppColors.accent.withOpacity(0.5),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    months[i],
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 9),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _keyVal(String key, String val, {Color? color}) {
    return Expanded(
      child: Column(
        children: [
          Text(
            val,
            style: TextStyle(
              color: color ?? AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(key, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _chip(String label, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
      child: Text(label,
          style: TextStyle(color: textColor, fontSize: 11, fontWeight: FontWeight.w500)),
    );
  }
}