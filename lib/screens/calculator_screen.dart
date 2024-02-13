import 'package:calculator/models/provider_data.dart';
import 'package:calculator/widgets/item_tils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    String result = Provider.of<ProviderData>(context).result;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Calculator'),
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              Text(
                'the result:$result',
                style: TextStyle(
                  color: context.read<ProviderData>().txtcolor,
                ),
              ),
              TextField(
                onChanged: (value) {
                  Provider.of<ProviderData>(context, listen: false).n1 = value;
                },
                decoration: InputDecoration(
                  hintText: 'N1',
                  label: Text('number1'),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                onChanged: (value) {
                  Provider.of<ProviderData>(context, listen: false).n2 = value;
                },
                decoration: const InputDecoration(
                  hintText: 'N2',
                  label: Text('number2'),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  Provider.of<ProviderData>(context, listen: false).sum();

                  context.read<ProviderData>().txtcolor = Colors.amber;
                  context.read<ProviderData>().addItem(result);
                },
                child: Text(
                  'Result',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("items Count ${context.read<ProviderData>().list.length}"),
              Expanded(
                child: ListView.builder(
                  itemCount: context.read<ProviderData>().list.length,
                  itemBuilder: (context, index) {
                    return ItemTils(context.read<ProviderData>().list[index]);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
