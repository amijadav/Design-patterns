import 'package:flutter/material.dart';
import 'view_model.dart';
import 'model.dart';

class ModelViewViewModelExample extends StatelessWidget {
  final ViewModel _viewModel = ViewModel();

  ModelViewViewModelExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MVVM')),
      body: Center(
        child: FutureBuilder<Model>(
          future: _viewModel.getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final snapshotData = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Title: ${snapshotData.title}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('Author: ${snapshotData.author}',
                      style: const TextStyle(fontSize: 16)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Summary: ${snapshotData.summary}',
                        textAlign: TextAlign.center),
                  ),
                ],
              );
            } else {
              return const Text('No data available');
            }
          },
        ),
      ),
    );
  }
}
