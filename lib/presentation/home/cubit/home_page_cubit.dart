import 'package:bloc/bloc.dart';
import 'package:devinity_recruitment_task/domain/plant.dart';
import 'package:devinity_recruitment_task/domain/plant_service.dart';
import 'package:injectable/injectable.dart';

import 'home_page_state.dart';

const int _elementsPerPage = 10;

@injectable
class HomePageCubit extends Cubit<HomePageState> {
  final PlantService _plantService;
  List<Plant> _plantsList = [];
  int _elementsOnPage = _elementsPerPage;

  HomePageCubit(this._plantService) : super(const Loading());

  Future<void> init() async {
    await _plantService.initializeDatabase();
    await getAllPlants();
  }

  Future<void> getAllPlants() async {
    _plantsList = await _plantService.getAllPlants();
    _emitShowView();
  }

  Future<void> searchPlantByName(String searchText) async {
    _elementsOnPage = _elementsPerPage;

    _emitShowView(isSearching: true);

    if (searchText.isNotEmpty) {
      _plantsList = await _plantService.findByName(searchText);
    } else {
      _plantsList = await _plantService.getAllPlants();
    }

    _emitShowView();
  }

  Future<void> loadMore() async {
    _elementsOnPage += _elementsPerPage;

    _emitShowView();
  }

  void _emitShowView({bool? isSearching}) {
    emit(ShowView(
      plants: _plantsList.reversed.take(_elementsOnPage).toList(),
      avaliableResults: _plantsList.length,
      isSearching: isSearching ?? false,
    ));
  }
}
