import 'package:bloc/bloc.dart';
import 'package:devinity_recruitment_task/domain/plant.dart';
import 'package:devinity_recruitment_task/domain/use_case/get_all_plants_use_case.dart';
import 'package:devinity_recruitment_task/domain/use_case/get_plant_by_name_use_case.dart';
import 'package:devinity_recruitment_task/domain/use_case/initialize_database_use_case.dart';
import 'package:injectable/injectable.dart';

import 'home_page_state.dart';

const int _elementsPerPage = 10;

@injectable
class HomePageCubit extends Cubit<HomePageState> {
  final InitializeDatabaseUseCase _initializeDatabaseUseCase;
  final GetAllPlantsUseCase _getAllPlantsUseCase;
  final GetPlantByNameUseCase _getPlantByNameUseCase;
  List<Plant> _plantsList = [];
  int _elementsOnPage = _elementsPerPage;

  HomePageCubit(
    this._initializeDatabaseUseCase,
    this._getAllPlantsUseCase,
    this._getPlantByNameUseCase,
  ) : super(const Loading());

  Future<void> init() async {
    await _initializeDatabaseUseCase();
    await getAllPlants();
  }

  Future<void> getAllPlants() async {
    try {
      _plantsList = await _getAllPlantsUseCase();
    } catch (e) {
      PresentError(message: e.toString());
    }
    _emitShowView();
  }

  Future<void> searchPlantByName(String searchText) async {
    _elementsOnPage = _elementsPerPage;

    _emitShowView(isSearching: true);

    try {
      if (searchText.isNotEmpty) {
        _plantsList = await _getPlantByNameUseCase(searchText);
      } else {
        _plantsList = await _getAllPlantsUseCase();
      }
    } catch (e) {
      PresentError(message: e.toString());
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
