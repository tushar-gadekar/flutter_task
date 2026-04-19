import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investor_app/application/home/home_bloc.dart';
import 'package:investor_app/presentation/core/theme/app_theme.dart';
import 'package:investor_app/presentation/core/utils/app_utils.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? selectedRisk;
  String? selectedIndustry;
  RangeValues roiRange = const RangeValues(0, 50);

  @override
  void initState() {
    super.initState();
    final state = context.read<DealBloc>().state;
    if (state is DealLoadedState) {
      selectedRisk = state.selectedRisk;
      selectedIndustry = state.selectedIndustry;
      if (state.minRoi != null && state.maxRoi != null) {
        roiRange = RangeValues(state.minRoi!, state.maxRoi!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filter Deals',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.read<DealBloc>().add(ClearFiltersEvent());
                  Navigator.pop(context);
                },
                child: const Text('Clear All', style: TextStyle(color: AppColors.accent)),
              ),
            ],
          ),
          const SizedBox(height: 20),

          const Text('Risk Level', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: AppUtils.riskLevels.map((risk) {
              final selected = selectedRisk == risk;
              return GestureDetector(
                onTap: () => setState(() {
                  selectedRisk = selected ? null : risk;
                }),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected
                        ? AppUtils.getRiskColor(risk).withOpacity(0.2)
                        : AppColors.inputFill,
                    border: Border.all(
                      color: selected ? AppUtils.getRiskColor(risk) : AppColors.divider,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    risk,
                    style: TextStyle(
                      color: selected ? AppUtils.getRiskColor(risk) : AppColors.textSecondary,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          const Text('Industry', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: AppUtils.industries.map((ind) {
              final selected = selectedIndustry == ind;
              return GestureDetector(
                onTap: () => setState(() {
                  selectedIndustry = selected ? null : ind;
                }),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.accent.withOpacity(0.15) : AppColors.inputFill,
                    border: Border.all(
                      color: selected ? AppColors.accent : AppColors.divider,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    ind,
                    style: TextStyle(
                      color: selected ? AppColors.accent : AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('ROI Range', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
              Text(
                '${roiRange.start.toInt()}% – ${roiRange.end.toInt()}%',
                style: const TextStyle(color: AppColors.accent, fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppColors.accent,
              inactiveTrackColor: AppColors.divider,
              thumbColor: AppColors.accent,
              overlayColor: AppColors.accent.withOpacity(0.1),
            ),
            child: RangeSlider(
              values: roiRange,
              min: 0,
              max: 50,
              divisions: 50,
              onChanged: (v) => setState(() => roiRange = v),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.read<DealBloc>().add(FilterDealsEvent(
                  riskLevel: selectedRisk,
                  industry: selectedIndustry,
                  minRoi: roiRange.start,
                  maxRoi: roiRange.end,
                ));
                Navigator.pop(context);
              },
              child: const Text('Apply Filters'),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}