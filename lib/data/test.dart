import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ExampleBuild extends StatefulWidget {
  const ExampleBuild({super.key});

  @override
  State<ExampleBuild> createState() => _ExampleBuildState();
}

class _ExampleBuildState extends State<ExampleBuild> {
  final List<int> numbers = List.generate(10_000, (i) => i);

  @override
  Widget build(BuildContext context) {
    final maxNumber = _maxNumber();

    return Column(
      children: [
        Text('Max Number is:'),
        Text('$maxNumber'),
      ],
    );
  }

  int _maxNumber() => numbers.reduce((a, b) => a > b ? a : b);
}

class ExampleBuild2 extends StatefulWidget {
  const ExampleBuild2({super.key});

  @override
  State<ExampleBuild2> createState() => _ExampleBuild2State();
}

class _ExampleBuild2State extends State<ExampleBuild2> {
  late List<String> _objects;

  @override
  void initState() {
    super.initState();

    seedObject();
  }

  Future<void> seedObject() async {
    final res = await compute(generateObject, 1);

    setState(() {
      _objects = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, int index) => CupertinoListTile(
        title: Text(_objects[index]),
      ),
    );
  }
}

List<String> generateObject(int seed) {
  // do heavy task here
  return [
    'object_1',
    'object_2',
  ];
}
