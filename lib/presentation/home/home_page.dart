import 'package:devinity_recruitment_task/core/infrastructure/injection/injection.dart';
import 'package:devinity_recruitment_task/presentation/home/cubit/home_page_cubit.dart';
import 'package:devinity_recruitment_task/presentation/home/cubit/home_page_state.dart';
import 'package:devinity_recruitment_task/presentation/home/widgets/plant_list_item.dart';
import 'package:devinity_recruitment_task/shared/theme/dimensions.dart';
import 'package:devinity_recruitment_task/shared/ui/widgets/input_field.dart';
import 'package:devinity_recruitment_task/shared/ui/widgets/loading_spinner.dart';
import 'package:devinity_recruitment_task/shared/ui/widgets/rounded_button.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: Dim.d20, vertical: Dim.d20),
          child: Row(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: Dim.d10),
                      child: Icon(Icons.search, color: Colors.grey),
                    ),
                    InputField(
                      hintText: "Search for a plant",
                      contentPadding: const EdgeInsets.only(left: Dim.d40),
                      onChanged: (text) => _searchPlant(cubit, text),
                    ),
                  ],
                ),
              ),
              Spacers.w15,
              RoundedButton(title: "+ Add plant", onPressed: () => _onAddPlantTap(context, cubit)),
            ],
          ),
        ),
        Spacers.h30,
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
        showView: (state) => _buildShowView(state),
        orElse: () => const SizedBox.shrink(),
      );

  Widget _buildShowView(ShowView state) {
    if (state.isSearching) {
      return const LoadingSpinner();
    } else if (state.plants.isNotEmpty) {
      return ListView.separated(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemCount: state.plants.length + 1,
        itemBuilder: (context, index) => _buildListItems(state, index),
        separatorBuilder: (context, index) => const Divider(),
      );
    } else {
      return const Text("NO PLANTS", style: TextStyle(fontSize: 20));
    }
  }

  Widget _buildListItems(ShowView state, int index) {
    if (state.plants.length == index && state.avaliableResults > state.plants.length) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: Dim.d5, horizontal: Dim.d100),
        child: RoundedButton(title: "Show more", onPressed: () => context.read<HomePageCubit>().loadMore()),
      );
    } else if (state.plants.length == index && state.avaliableResults <= state.plants.length) {
      return const SizedBox.shrink();
    } else {
      return PlantListItem(plant: state.plants[index], refreshPage: context.read<HomePageCubit>().getAllPlants);
    }
  }

  void _searchPlant(HomePageCubit cubit, String searchText) => cubit.searchPlantByName(searchText);
  void _onAddPlantTap(BuildContext context, HomePageCubit cubit) {
    FocusScope.of(context).unfocus();
    Navigator.pushNamed(context, '/plant-form').whenComplete(cubit.getAllPlants);
  }
}
