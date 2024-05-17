part of 'general_cubit.dart';

sealed class GeneralState extends Equatable {
  const GeneralState();

  @override
  List<Object> get props => [];
}

final class GeneralStats extends GeneralState {
  final int navigationIndex;
  final int category;
  final int adminIndex;
  final String role;
  const GeneralStats(this.navigationIndex, this.category, this.adminIndex, this.role);

  @override
  List<Object> get props => [navigationIndex, category, adminIndex, role];


}
