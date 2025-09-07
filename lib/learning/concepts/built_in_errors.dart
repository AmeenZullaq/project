void main() {
  int addTen(int num) {
    print('add ten');
    return num + 10;
  }

  final myIterable = Iterable<int>.generate(10, (i) => i);
  final newIterableAfterAddingTen = myIterable.map(addTen);

  for (var element in myIterable) {
    print(newIterableAfterAddingTen);
    print(element);
  }


  // 1. Dividing by zero error

  // print(1 ~/ 0); // IntegerDivisionByZeroException
  // print(1 / 0); // there is no error and will print Infinity

  //*************************************************
  // 2. No Such Method error

//  dynamic x = null;
//  print(x.isEven); // NoSuchMethodError: The getter 'isEven' was called on null.
  // there is no isEven method in null class

  //*************************************************
  // 3. FormateException

  // String message = 'hello';
  // int x= int.parse(message);

  //*************************************************
  // 4. RangeError

  // List list = [1, 2, 3];
  // list[10]; // RangeError (index): Invalid value: Not in range 0..2: 10
}




