/*
🔁 Iterable
Lazy evaluation – operations like .map(), .where() are not executed until the iterable is actually used (e.g., in a for loop).
 
 🧠 Think of it like a recipe:
You write down steps for making a sandwich (.map() or .where()),

But you don’t make it until someone says “Okay, now eat it” (like a for loop or toList()).



| Feature      | Iterable              | List                     |
| ------------ | --------------------- | ------------------------ |

| Evaluation   | Lazy                  | Eager                    |

| Index access | ❌ No                  | ✅ Yes                    |

| Memory       | Low usage (initially) | Uses memory immediately  |

| Modifiable   | ❌ Usually not         | ✅ Yes                    |

| Methods      | Few basic ones        | Many (add, remove, etc.) |

=============================================================================

🔑 async* with yield
    =================
✅ async*
Used to mark a function as an asynchronous generator.

That function returns a Stream<T> instead of a Future<T>.

✅ yield
Used inside async* functions to emit a value to the stream.

Think of it like return, but it allows multiple values over time.


🔑 sync* and yield
    =================
✅ sync*
Used to define a synchronous generator.

Returns an Iterable<T>, not a Stream<T>

=============================================================================

Example with tracing:
====================

int addTen(int number) {
  print('addTen called');
  return number + 10;
}


int multiplyByTwo(int number) {
  print('mutiply by two called');
  return number * 2;
}


int divideByFour(int number) {
  print('divide by four called');
  return number / 4;
}



void main() {
  final myIterable = Iterable.generate(3, (i) => i); // 0, 1, 2

  final mapped = myIterable.map(addTen); // nothing printed yet, it is lazy and will wait for us to use it in a for loop or toList, and that line like a pipeline of functions.

  for (var value in mapped) {
    print('Result: $value');
  }
}

🧠 Step-by-step Trace

🔄 Iteration 1:
addTen(0) is called
✅ Output: addTen called
Returns 10

print('Result: $value') →
✅ Output: Result: 10

🔄 Iteration 2:
addTen(1) is called
✅ Output: addTen called
Returns 11

print('Result: $value')
✅ Output: Result: 11

🔄 Iteration 3:
addTen(2) is called
✅ Output: addTen called
Returns 12

print('Result: $value')
✅ Output: Result: 12


=============================================================================

🔑 How to create Iterable
=========================
Iterable<int> myIterable = createMyIterable();

Iterable<int> createMyIterable() sync* {
  for (int i = 0; i < 3; i++) {
    yield i;
    print('from iterable');
  }
}

final mapped = myIterable.map(addTen).map(multiplyByTwo).map(divideByFour).take(3); // nothing printed yet , and that line like a pipeline of functions 
final mapped = myIterable.map(addTen).map(multiplyByTwo).map(divideByFour).take(3).toList(); // when we use toList it will print all the values.

🧠 Step-by-step Trace

addTen called with 0
multiplyByTwo called with 0
divideByFour called with 20
from iterable
addTen called with 1
multiplyByTwo called with 11
divideByFour called with 22
from iterable
addTen called with 2
multiplyByTwo called with 12
divideByFour called with 24
from iterable
Final list: [5, 5, 6]

 */
