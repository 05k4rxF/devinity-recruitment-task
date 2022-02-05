import 'package:bloc/bloc.dart';
import 'package:devinity_recruitment_task/domain/plant.dart';
import 'package:devinity_recruitment_task/domain/plant_service.dart';
import 'package:injectable/injectable.dart';

import 'home_page_state.dart';

@injectable
class HomePageCubit extends Cubit<HomePageState> {
  final PlantService _plantService;
  List<Plant> _plantsList = [];

  HomePageCubit(this._plantService) : super(const Loading());

  Future<void> init() async {
    await _plantService.initializeDatabase();
    _plantsList = await _plantService.getAllPlants();

    emit(ShowView(plants: _plantsList));
  }

  Future<void> searchPlantByName(String searchText) async {
    emit(ShowView(plants: _plantsList, isSearching: true));

    if (searchText.isNotEmpty) {
      _plantsList = await _plantService.findByName(searchText);
    } else {
      _plantsList = await _plantService.getAllPlants();
    }

    emit(ShowView(plants: _plantsList));
  }
}
