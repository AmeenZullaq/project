// /*
// · defines a family of algorithms,
// · encapsulates each algorithm,
// · makes the algorithms interchangeable within that family.
// */
// abstract class Duck {
//   late FlyBehavior flyBehavior;
//   late QuackBehavior quackBehavior;
//   void swim() {
//     print('all ducks can swim');
//   }

//   void performFly() {
//     flyBehavior.fly();
//   }

//   void performQuack() {
//     quackBehavior.quack();
//   }

//   void
//       display(); // we do not pull display method out because it fixed, meand do not change at run time
// }

// abstract class FlyBehavior {
//   // this class called the strategy
//   void fly(); // this called algorithm
// }

// abstract class QuackBehavior {
//   void quack();
// }

// class FlyWithWings extends FlyBehavior {
//   // this class is the concrete strategy
//   @override
//   void fly() {
//     print('fly'); // this is the algorithm implementation
//   }
// }

// class FlyNoWay extends FlyBehavior {
//   @override
//   void fly() {
//     print('can not fly');
//   }
// }

// class Quack extends QuackBehavior {
//   @override
//   void quack() {
//     print('quack');
//   }
// }

// class Squeak extends QuackBehavior {
//   @override
//   void quack() {
//     print('squeak');
//   }
// }

// class MuteQuack implements QuackBehavior {
//   @override
//   void quack() {
//     print('<< Silence >>');
//   }
// }

// class MalluredDuck extends Duck {
//   MalluredDuck() {
//     flyBehavior = FlyWithWings();
//     quackBehavior = Quack();
//   }
//   @override
//   void display() {
//     print('MalluredDuck');
//   }
// }

// class RedHeadDuck extends Duck {
//   RedHeadDuck() {
//     flyBehavior = FlyWithWings();
//     quackBehavior = Quack();
//   }
//   @override
//   void display() {
//     print('RedHeadDuck');
//   }
// }

// class RubberDuck extends Duck {
//   RubberDuck() {
//     flyBehavior = FlyNoWay();
//     quackBehavior = Squeak();
//   }
//   @override
//   void display() {
//     print('RubberDuck');
//   }
// }

// class WoodenDuck extends Duck {
//   WoodenDuck() {
//     flyBehavior = FlyNoWay();
//     quackBehavior = MuteQuack();
//   }
//   @override
//   void display() {
//     print('WoodenDuck');
//   }
// }

// void main() {
//   Duck mallardDuck = MalluredDuck();
//   Duck woodenDuck = WoodenDuck();
//   print('============================mallard duck');
//   mallardDuck.display();
//   mallardDuck.performFly();
//   mallardDuck.performQuack();
//   mallardDuck.swim();

// // change fly behavior at run time

//   mallardDuck.flyBehavior = FlyNoWay();

//   print('============================woodenDuck');
//   woodenDuck.display();
//   woodenDuck.performFly();
//   woodenDuck.performQuack();
//   woodenDuck.swim();
// }

abstract class Character {
  late WeabonBehavior weabonBehavior;
  setWeabon(WeabonBehavior weabonBehavior) {
    this.weabonBehavior = weabonBehavior;
  }

  void fight() {
    weabonBehavior.useWeabon();
  }
}

abstract class WeabonBehavior {
  void useWeabon();
}

class Knife extends WeabonBehavior {
  @override
  void useWeabon() {
    print('fight with knife');
  }
}

class Axe extends WeabonBehavior {
  @override
  void useWeabon() {
    print('fight with axe');
  }
}

class BowAndArrow extends WeabonBehavior {
  @override
  void useWeabon() {
    print('fight with bow and arrow');
  }
}

class Soward extends WeabonBehavior {
  @override
  void useWeabon() {
    print('fight with saword');
  }
}

class Queen extends Character {
  Queen() {
    weabonBehavior = Knife();
  }
}

class King extends Character {
  King() {
    weabonBehavior = Soward();
  }
}

class Trool extends Character {
  Trool() {
    weabonBehavior = BowAndArrow();
  }
}

class Knight extends Character {
  Knight() {
    weabonBehavior = Axe();
  }
}
