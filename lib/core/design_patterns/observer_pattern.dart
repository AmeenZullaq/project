/* 
observer -> UI
observable -> state management (bloc)
*/

abstract class Observer {
  void update();
}

abstract class Observable {
  void registerObserver();
  void removeObserver();
  void notifyObserver();
}

class ConcreteObserver implements Observer {
  @override
  void update() {
    print('updating');
  }
}

class ConcreteObservable implements Observable {
  @override
  void registerObserver() {
    print('register observer');
  }

  @override
  void removeObserver() {
    print('remove observer');
  }

  @override
  void notifyObserver() {
    print('notify observer');
  }

  void getState() {}
  void setState() {}
}


// example in flutter using provider  

/*
1.............. Create the Subject (Notifier) (observable)

import 'package:flutter/foundation.dart';

class Counter extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners(); // Notify observers
  }
}

2................ Provide the Subject (Using Provider)
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'counter.dart'; // the file with Counter class
import 'home_screen.dart'; // your UI

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => Counter(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

3................. Create the Observer (UI using Consumer)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'counter.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = context.watch<Counter>();

    return Scaffold(
      appBar: AppBar(title: Text("Observer Pattern Example")),
      body: Center(
        child: Text(
          'Counter: ${counter.count}',
          style: TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counter.increment(),
        child: Icon(Icons.add),
      ),
    );
  }
}

 */