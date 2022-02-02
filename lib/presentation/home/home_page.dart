import 'package:devinity_recruitment_task/core/infrastructure/injection/injection.dart';
import 'package:devinity_recruitment_task/presentation/home/cubit/home_page_cubit.dart';
import 'package:devinity_recruitment_task/presentation/home/cubit/home_page_state.dart';
import 'package:devinity_recruitment_task/shared/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomePageCubit>(
      create: (_) => getIt<HomePageCubit>()..init(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Garden"),
        ),
        body: const _Body(),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomePageCubit>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dim.d50, vertical: Dim.d50),
          child: TextField(onChanged: (text) => _searchPlant(cubit, text)),
        ),
        ElevatedButton(
          onPressed: () => _onAddPlantTap(context),
          child: const Text("+ Add plant"),
        ),
        Spacers.h50,
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dim.d30),
            child: BlocBuilder<HomePageCubit, HomePageState>(
              buildWhen: (previous, current) => current is ShowView,
              builder: (context, state) => _builder(state),
            ),
          ),
        )
      ],
    );
  }

  Widget _builder(HomePageState state) => state.maybeMap(
        showView: (state) => state.plants.isNotEmpty
            ? ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.plants.length,
                itemBuilder: (context, index) => _listItemBuilder(context),
              )
            : const Text(
                "NO PLANTS YET",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
        orElse: () => const SizedBox.shrink(),
      );

  Widget _listItemBuilder(BuildContext context) {
    return GestureDetector(
      onTap: () => _onEditPlantTap(context),
      child: const Text("ABC"),
    );
  }

  void _onAddPlantTap(BuildContext context) => Navigator.pushNamed(context, '/plant-form');
  void _onEditPlantTap(BuildContext context) => Navigator.pushNamed(context, '/plant-form');
  void _searchPlant(HomePageCubit cubit, String searchText) => cubit.searchPlantByName(searchText);
}
