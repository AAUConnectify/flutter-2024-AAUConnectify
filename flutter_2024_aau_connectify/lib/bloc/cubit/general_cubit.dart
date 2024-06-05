import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'general_state.dart';

class GeneralCubit extends Cubit<GeneralState> {
  GeneralCubit() : super(const GeneralStats(0, 0));
  //get the current navigation index
  int get navigationIndex => (state as GeneralStats).navigationIndex;
  //get the current category index
  int get category => (state as GeneralStats).category;
  //set the navigation index
  void setNavigationIndex(int index) {
    emit(GeneralStats(index, category));
  }
  //set the category index
  void setCategory(int index) {
    emit(GeneralStats(navigationIndex, index));
  }
  
}
