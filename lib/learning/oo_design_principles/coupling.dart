/*
There are two types of coupling :
1. loose coupling .
2. tight coupling .

note that : tight coupling depend on concrete class,
            but loose coupling depend on abstraction. 
*/

// tight coupling example

class Engine {
  void startengin() {
    print('Start Engin');
  }
}

class Car {
  Engine engine = Engine();

  void startCar() {
    engine.startengin();
    // in that way we can not reuse this car with other tupes of engine like (ElectricEngine)
    print('Start Car');
  }
}

// loose cooupling example

abstract class Enginee {
  void startEngin();
}

class DieselEngine extends Enginee {
  @override
  void startEngin() {
    print('Start Diesel Engine');
  }
}

class ElectricEngine extends Enginee {
  @override
  void startEngin() {
    print('Start Electric Engine');
  }
}

class Carr {
  final Enginee enginee;

  Carr({required this.enginee});

  void startCar() {
    enginee.startEngin();
    // here we can use this function with any type of engine
    print('Start Car');
  }
}
