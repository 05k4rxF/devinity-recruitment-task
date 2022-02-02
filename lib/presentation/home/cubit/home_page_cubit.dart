import 'package:bloc/bloc.dart';
import 'package:devinity_recruitment_task/domain/plant_service.dart';
import 'package:injectable/injectable.dart';

import 'home_page_state.dart';

@injectable
class HomePageCubit extends Cubit<HomePageState> {
  final PlantService _plantService;

  HomePageCubit(this._plantService) : super(const Loading());

  Future<void> init() async {
    await _plantService.initializeDatabase();
    final _plants = await _plantService.getAllPlants();

    emit(ShowView(plants: _plants));
  }

  Future<void> searchPlantByName(String searchText) async {
    if (searchText.length > 3) {
      final _result = await _plantService.findByName(searchText);

      if (_result.isNotEmpty) {
        emit(ShowView(plants: _result));
      }
    }
  }
}
