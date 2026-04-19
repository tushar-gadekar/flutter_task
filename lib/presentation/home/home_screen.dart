import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investor_app/application/auth/auth_bloc.dart';
import 'package:investor_app/application/home/home_bloc.dart';
import 'package:investor_app/infrastructure/home/repositories/deal_repositry_impl.dart';
import 'package:investor_app/presentation/core/theme/app_theme.dart';
import 'package:investor_app/presentation/home/widgets/deal_card.dart';
import 'package:investor_app/presentation/home/widgets/filter_bottom_sheet.dart';
import 'deal_detail_screen.dart';
import 'my_interests_screen.dart';
import 'login_screen.dart';

class DealListScreen extends StatelessWidget {
  const DealListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DealBloc(DealRepositryImpl())..add(LoadDealsEvent()),
      child: const _DealListView(),
    );
  }
}

class _DealListView extends StatefulWidget {
  const _DealListView();

  @override
  State<_DealListView> createState() => _DealListViewState();
}

class _DealListViewState extends State<_DealListView> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.trending_up, color: AppColors.accent, size: 20),
            SizedBox(width: 8),
            Text('DealFlow'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_outlined, color: AppColors.accent),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MyInterestsScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, size: 20),
            onPressed: () {
              context.read<AuthBloc>().add(LogoutEvent());
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchCtrl,
                    style: const TextStyle(color: AppColors.textPrimary),
                    onChanged: (val) {
                      context.read<DealBloc>().add(SearchDealsEvent(val));
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search by company...',
                      prefixIcon: Icon(Icons.search, color: AppColors.textSecondary, size: 20),
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                BlocBuilder<DealBloc, DealState>(
                  builder: (context, state) {
                    bool hasFilter = false;
                    if (state is DealLoadedState) {
                      hasFilter = state.selectedRisk != null ||
                          state.selectedIndustry != null ||
                          state.minRoi != null;
                    }
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => BlocProvider.value(
                            value: context.read<DealBloc>(),
                            child: const FilterBottomSheet(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: hasFilter
                              ? AppColors.accent.withOpacity(0.2)
                              : AppColors.inputFill,
                          border: Border.all(
                            color: hasFilter ? AppColors.accent : AppColors.divider,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.tune,
                          color: hasFilter ? AppColors.accent : AppColors.textSecondary,
                          size: 20,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          BlocBuilder<DealBloc, DealState>(
            builder: (context, state) {
              if (state is! DealLoadedState) return const SizedBox();
              final chips = <Widget>[];
              if (state.selectedRisk != null) {
                chips.add(_filterChip(context, state.selectedRisk!, () {
                  context.read<DealBloc>().add(FilterDealsEvent(
                    industry: state.selectedIndustry,
                    minRoi: state.minRoi,
                    maxRoi: state.maxRoi,
                  ));
                }));
              }
              if (state.selectedIndustry != null) {
                chips.add(_filterChip(context, state.selectedIndustry!, () {
                  context.read<DealBloc>().add(FilterDealsEvent(
                    riskLevel: state.selectedRisk,
                    minRoi: state.minRoi,
                    maxRoi: state.maxRoi,
                  ));
                }));
              }
              if (chips.isEmpty) return const SizedBox();
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(children: chips),
              );
            },
          ),
          Expanded(
            child: BlocBuilder<DealBloc, DealState>(
              builder: (context, state) {
                if (state is DealLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.accent),
                  );
                }
                if (state is DealErrorState) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.error_outline, color: AppColors.riskHigh, size: 48),
                        const SizedBox(height: 12),
                        Text(state.message, style: const TextStyle(color: AppColors.textSecondary)),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => context.read<DealBloc>().add(LoadDealsEvent()),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }
                if (state is DealLoadedState) {
                  if (state.filteredDeals.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.search_off, color: AppColors.textSecondary, size: 48),
                          SizedBox(height: 12),
                          Text(
                            'No deals found',
                            style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 24, top: 4),
                    itemCount: state.filteredDeals.length,
                    itemBuilder: (ctx, i) {
                      final deal = state.filteredDeals[i];
                      final isIntrested = state.intrestedIds.contains(deal.id);
                      return DealCard(
                        deal: deal,
                        isIntrested: isIntrested,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: context.read<DealBloc>(),
                                child: DealDetailScreen(deal: deal, isIntrested: isIntrested),
                              ),
                            ),
                          );
                        },
                        onIntrestToggle: () {
                          if (isIntrested) {
                            context.read<DealBloc>().add(RemoveIntrestEvent(deal.id));
                          } else {
                            context.read<DealBloc>().add(MarkIntrestEvent(deal));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    const Icon(Icons.check_circle, color: AppColors.primary, size: 16),
                                    const SizedBox(width: 8),
                                    Text('Interest marked for ${deal.companyName}'),
                                  ],
                                ),
                                backgroundColor: AppColors.accent,
                                duration: const Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            );
                          }
                        },
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(BuildContext context, String label, VoidCallback onRemove) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.15),
        border: Border.all(color: AppColors.accent.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: const TextStyle(color: AppColors.accent, fontSize: 12)),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(Icons.close, size: 14, color: AppColors.accent),
          ),
        ],
      ),
    );
  }
}