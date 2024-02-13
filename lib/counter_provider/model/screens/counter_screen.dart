import 'dart:ffi';

import 'package:calculator/counter_provider/model/LanguageProvider.dart';
import 'package:calculator/counter_provider/model/counter_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First App"),
        backgroundColor: Colors.blue,
        actions: [
          GestureDetector(
              onTap: () {
                context.read<LanguageProvider>().translate();
              },
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  context.watch<LanguageProvider>().lng,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${context.watch<LanguageProvider>().txt}',
              style: TextStyle(
                fontSize: context.watch<CounterProvider>().counter.toDouble(),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            Column(
              children:[
              ChangeNotifierProvider(
                create: (context)=>CounterProvider(),
                child: Consumer<CounterProvider>(
                  builder: (BuildContext context, CounterProvider _counter, Widget? child) {
                 return Card(
                    child: Container(
                      child: Column(
                        children: [
                          Text(
                            '${context.watch<CounterProvider>().counter}',
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(
                            'Teshirt',
                            style: TextStyle(fontSize: 24),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(

                                onPressed: () {
                                  context.read<CounterProvider>().increment();
                                },
                                child: Text(
                                  '+',
                                  style:
                                      TextStyle(fontSize: 20, color: Colors.black),

                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              ElevatedButton(

                                onPressed: () {
                                  context.read<CounterProvider>().decrement();
                                },
                                child: Text(
                                  '-',
                                  style:
                                      TextStyle(fontSize: 20, color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                  },
                ),
              ),

                ChangeNotifierProvider(
                  create: (context)=>CounterProvider(),
                  child: Consumer<CounterProvider>(
                    builder: (BuildContext context, _counter, Widget? child) {
                    return Card(
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              '${_counter.counter}',
                              style: TextStyle(fontSize: 24),
                            ),

                            Text(
                              'Book',
                              style: TextStyle(fontSize: 24),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    _counter.increment();
                                  },
                                  child: Text(
                                    '+',
                                    style: TextStyle(fontSize: 20, color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _counter.decrement();
                                  },
                                  child: Text(
                                    '-',
                                    style: TextStyle(fontSize: 20, color: Colors.white),
                                  ),
                                )
                              ],
                            ),

                          ],


                        ),


                      ),

                    );
                    },
                  ),
                ),
            ]
            ),

          ],
        ),
      ),
    );
  }
}
