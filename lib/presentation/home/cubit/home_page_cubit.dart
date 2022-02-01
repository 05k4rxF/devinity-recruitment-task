import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import 'home_page_state.dart';

@injectable
class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(const Loading());
}
