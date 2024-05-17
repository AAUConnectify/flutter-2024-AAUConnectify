import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'general_state.dart';

class GeneralCubit extends Cubit<GeneralState> {
  GeneralCubit() : super(const GeneralStats(0, 0, 0, 'user'));

  //get the current navigation index
  int get navigationIndex => (state as GeneralStats).navigationIndex;
  //get the current category index
  int get category => (state as GeneralStats).category;
  //get the current admin index
  int get adminIndex => (state as GeneralStats).adminIndex;
  //get the current role
  String get role => (state as GeneralStats).role;

  //set the navigation index
  void setNavigationIndex(int index) {
    emit(GeneralStats(index, category, adminIndex, role));
  }

  //set the category index
  void setCategory(int index) {
    emit(GeneralStats(navigationIndex, index, adminIndex, role));
  }

  //set the admin index
  void setAdminIndex(int index) {
    emit(GeneralStats(navigationIndex, category, index, role));
  }

  //set the role
  void setRole(String role) {
    emit(GeneralStats(navigationIndex, category, adminIndex, role));
  }
}
