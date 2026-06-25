ex==========================================
T getValue<T>(T value) {
  return value;
}

void main() {
  print(getValue<int>(42));
  print(getValue<String>('hello'));
  print(getValue('world'));
  print(getValue(3.14));
}
output: 
42
hello
world
3.14

// call 1 — T explicitly set to int
print(getValue<int>(42));
//             ^^^
//             T = int — you told Dart explicitly
//             method becomes: int getValue(int value)
//             output: 42 ✅

// call 2 — T explicitly set to String
print(getValue<String>('hello'));
//             ^^^^^^
//             T = String — you told Dart explicitly
//             method becomes: String getValue(String value)
//             output: hello ✅

// call 3 — T inferred by Dart
print(getValue('world'));
//             ^^^^^^^
//             no <T> specified — Dart looks at argument
//             argument is String → T = String inferred ✅
//             method becomes: String getValue(String value)
//             output: world ✅

// call 4 — T inferred by Dart
print(getValue(3.14));
//             ^^^^
//             no <T> specified — Dart looks at argument
//             argument is double → T = double inferred ✅
//             method becomes: double getValue(double value)
//             output: 3.14 ✅
====================================================================================================================================================================================================================
# Generics & Type System — Repository Pattern
# Interview Question & Full Answer

---

## The Code

```dart
class Repository<T extends Entity> {
  final List<T> _items = [];

  void save(T item) {
    _items.add(item);
  }

  T? findById(String id) {
    return _items.firstWhereOrNull((e) => e.id == id);
  }
}

abstract class Entity {
  String get id;
}

class User extends Entity {
  final String id;
  final String name;
  User(this.id, this.name);
}

class Product extends Entity {
  final String id;
  final String title;
  Product(this.id, this.title);
}
```

---

## Question 1 — Why `T extends Entity` instead of just `T`?

```
Without extends Entity:
  T could be anything — String, int, bool
  e.id inside findById would be a compile error
  because not every type has an id property

With extends Entity:
  T is forced to be Entity or any subclass of Entity
  so e.id is always safe — every Entity has id ✅
  compiler guarantees it
```

```dart
// without bound — dangerous
class Repository<T> {
  T? findById(String id) {
    return _items.firstWhereOrNull((e) => e.id == id); // ❌ compile error
    //                                         ^^
    //                                         T might not have id
  }
}

// with bound — safe
class Repository<T extends Entity> {
  T? findById(String id) {
    return _items.firstWhereOrNull((e) => e.id == id); // ✅ safe
    //                                         ^^
    //                                         Entity always has id
  }
}
```

---

## Question 2 — Which Lines Compile?

```dart
Repository<User> userRepo = Repository<User>();
// ✅ compiles — User extends Entity

Repository<Product> productRepo = Repository<Product>();
// ✅ compiles — Product extends Entity

Repository<String> stringRepo = Repository<String>();
// ❌ compile error — String does not extend Entity

Repository userRepo2 = Repository();
// ⚠️ compiles with WARNING — not an error
// T becomes dynamic — you lose all type safety
// dangerous — always specify the type
```

---

## Question 3 — Why does `findById` return `T?` and not `T`?

```
firstWhereOrNull returns null if no item matches the id
the item might not exist in the list
so the return type must be T? to handle that case

if return type was T — compile error
because T is non-nullable but null could be returned
```

```dart
// if item found   → returns T  ✅
// if item missing → returns null ✅
T? findById(String id) {
  return _items.firstWhereOrNull((e) => e.id == id);
}

// caller must handle null
final user = userRepo.findById('123');
if (user != null) {
  print(user.name); // ✅ safe
}

// or null aware
final name = userRepo.findById('123')?.name ?? 'not found';
```

---

## Question 4 — Benefits of This Pattern in Real Flutter App

### 1. Reusability — one class handles all entity types
```dart
Repository<User>    userRepo    = Repository();
Repository<Product> productRepo = Repository();
Repository<Order>   orderRepo   = Repository();
// same logic — different types ✅ no code duplication
```

### 2. Type Safety — compiler catches wrong types early
```dart
userRepo.save(Product(...)); // ❌ compile error — caught before runtime
userRepo.save(User(...));    // ✅ correct
```

### 3. Clean Architecture — shared base repository
```dart
abstract class BaseRepository<T extends Entity> {
  Future<T?> findById(String id);
  Future<void> save(T entity);
  Future<List<T>> getAll();
}

class UserRepository extends BaseRepository<User> { ... }      // ✅
class ProductRepository extends BaseRepository<Product> { ... } // ✅
class OrderRepository extends BaseRepository<Order> { ... }    // ✅
```

### 4. Testable — easy to mock
```dart
class MockRepository<T extends Entity> extends Repository<T> {
  // mock implementation for tests ✅
}

// in tests
final mockRepo = MockRepository<User>();
mockRepo.save(User('1', 'Ameen'));
```

---

## One Line Answers for Interview

```
What is T extends Entity?
→ a bounded type — forces T to be Entity or any subclass of it

Why bound the type?
→ to safely access Entity properties like id inside the class

What happens with Repository<String>?
→ compile error — String does not extend Entity

What happens with Repository without type?
→ compiles with warning — T becomes dynamic — unsafe

Why return T? not T?
→ item might not exist in list — firstWhereOrNull can return null

Main benefits of generic repository?
→ reusability, type safety, clean architecture, testability
```
=======================================================================================================================================================================================================

# Generics — Multiple Type Parameters
# Interview Question & Full Answer

---

## The Code

```dart
T first<T>(List<T> list) => list[0];

S transform<T, S>(T value, S Function(T) converter) {
  return converter(value);
}
```

---

## Question 1 — What does `S Function(T)` mean?

```
S Function(T) is a callback with generic types:
  takes  → T as parameter
  returns → S as result

simple words:
  "give me a function that takes T and returns S"
  the caller decides what T and S are
```

```dart
// example — T = String, S = int
S Function(T) → int Function(String)
// a function that takes String and returns int

(s) => s.length  // ✅ takes String, returns int — matches perfectly
```

---

## Question 2 — Output

```dart
void main() {
  final nums = [1, 2, 3];
  print(first(nums));
  // T = int inferred from List<int>
  // first element = 1
  // output: 1

  final result1 = transform<String, int>('hello', (s) => s.length);
  print(result1);
  // T = String, S = int
  // converter: (s) => s.length
  // 'hello'.length = 5
  // output: 5

  final result2 = transform<int, String>(42, (n) => 'number: $n');
  print(result2);
  // T = int, S = String
  // converter: (n) => 'number: $n'
  // output: number: 42
}
```

### Final Output:
```
1
5
number: 42
```

---

## Question 3 — What are T and S in each call?

```dart
// call 1 — first()
first(nums)
// T = int — inferred from List<int>
// list[0] returns int

// call 2 — transform<String, int>
transform<String, int>('hello', (s) => s.length)
// T = String → type of value parameter 'hello'
//              type of converter parameter s
// S = int    → return type of converter s.length
//              return type of transform itself

// call 3 — transform<int, String>
transform<int, String>(42, (n) => 'number: $n')
// T = int    → type of value parameter 42
//              type of converter parameter n
// S = String → return type of converter 'number: $n'
//              return type of transform itself
```

---

## Question 4 — Can you call transform without specifying T and S?

```
YES — and Dart gives NO warning

Dart infers T and S automatically
by looking at the arguments you pass

Dart only warns when it CANNOT infer the types
which almost never happens with good code
```

```dart
// explicit — you tell Dart
final result1 = transform<String, int>('hello', (s) => s.length);

// inferred — Dart figures it out ✅ no warning at all
final result1 = transform('hello', (s) => s.length);
//                         ^^^^^^   ^^^^^^^^^^^^^^^^^^^
//                         String → T = String inferred ✅
//                         returns int → S = int inferred ✅

// both produce identical results
// inferred version is cleaner and preferred
```

---

## Key Concepts to Remember

```
T first<T>(List<T> list)
  T declared on method → T is whatever the list contains
  Dart infers T from the list you pass

S transform<T, S>(T value, S Function(T) converter)
  TWO type parameters — T and S can be different types
  T → type going IN  (value parameter, converter input)
  S → type coming OUT (converter output, method return type)
  S Function(T) → a callback: takes T, returns S

Type inference:
  explicit → transform<String, int>(...)  you decide T and S
  inferred → transform('hello', ...)      Dart decides T and S
  both work the same — inferred is cleaner
```

---

## One Line Answers for Interview

```
What is S Function(T)?
→ a generic callback — takes T as parameter and returns S

What is the difference between T and S in transform?
→ T is the input type, S is the output type

Can you skip specifying <T, S> when calling transform?
→ yes — Dart infers both types from the arguments automatically

Does Dart warn when you skip type parameters?
→ no warning — Dart infers silently unless it cannot figure out the types

What is type inference?
→ Dart automatically determines generic types from context
   so you don't have to specify them explicitly every time
```