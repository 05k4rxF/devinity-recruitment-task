import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import 'add_plant_form_state.dart';

@injectable
class AddPlantFormCubit extends Cubit<AddPlantFormState> {
  AddPlantFormCubit() : super(const Loading());
}
