import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import 'add_plant_form_state.dart';

@injectable
class PlantFormPageCubit extends Cubit<PlantFormPageState> {
  PlantFormPageCubit() : super(const Loading());
}
