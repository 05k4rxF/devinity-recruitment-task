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
            onPressed: _onAddPlantTap,
            child: const Text("+ Add plant"),
          ),
          const SizedBox(height: 50),
          Expanded(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) => const Text("ABC"),
            ),
          )
        ],
      ),
    );
  }

  void _onAddPlantTap() {
    return;
  }
}
