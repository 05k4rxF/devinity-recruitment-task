import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Garden"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          const TextField(),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () => _onAddPlantTap(context),
            child: const Text("+ Add plant"),
          ),
          const SizedBox(height: 50),
          Expanded(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) => _listItemBuilder(context),
            ),
          )
        ],
      ),
    );
  }

  GestureDetector _listItemBuilder(BuildContext context) {
    return GestureDetector(
      onTap: () => _onEditPlantTap(context),
      child: const Text("ABC"),
    );
  }

  void _onAddPlantTap(BuildContext context) => Navigator.pushNamed(context, '/plant-form');
  void _onEditPlantTap(BuildContext context) => Navigator.pushNamed(context, '/plant-form');
}
