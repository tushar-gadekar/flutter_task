import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investor_app/application/home/home_bloc.dart';
import 'package:investor_app/infrastructure/home/repositories/deal_repositry_impl.dart';
import 'package:investor_app/presentation/core/theme/app_theme.dart';
import 'package:investor_app/presentation/home/widgets/deal_card.dart';
import 'deal_detail_screen.dart';

class MyInterestsScreen extends StatelessWidget {
  const MyInterestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DealBloc(DealRepositryImpl())..add(LoadIntrestedDealsEvent()),
      child: const _MyIntrestsView(),
    );
  }
}

class _MyIntrestsView extends StatelessWidget {
  const _MyIntrestsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Interests'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<DealBloc, DealState>(
        builder: (context, state) {
          if (state is DealLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.accent),
            );
          }

          if (state is DealErrorState) {
            return Center(
              child: Text(state.message, style: const TextStyle(color: AppColors.textSecondary)),
            );
          }

          if (state is IntrestedDealsLoadedState) {
            if (state.deals.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.bookmark_border, color: AppColors.textSecondary, size: 56),
                    SizedBox(height: 16),
                    Text(
                      'No interests yet',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Browse deals and mark your interests',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                  child: Row(
                    children: [
                      Text(
                        '${state.deals.length} deal${state.deals.length > 1 ? 's' : ''} saved',
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 24),
                    itemCount: state.deals.length,
                    itemBuilder: (ctx, i) {
                      final deal = state.deals[i];
                      return DealCard(
                        deal: deal,
                        isIntrested: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: context.read<DealBloc>(),
                                child: DealDetailScreen(deal: deal, isIntrested: true),
                              ),
                            ),
                          );
                        },
                        onIntrestToggle: () {
                          context.read<DealBloc>().add(RemoveIntrestEvent(deal.id));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Removed interest in ${deal.companyName}'),
                              backgroundColor: AppColors.riskMedium,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}