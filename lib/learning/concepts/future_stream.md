# Future & Stream — Complete Interview Study Guide

---

## PART 1 — FUTURE

---

### 1.1 What is a Future?

```
A Future is a promise that a single value will arrive later.
One value → arrives once → Future is done.
```

```dart
Future<String> getName() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Ameen'; // one value, function ends
}
```

---

### 1.2 Future States

```
uncompleted  → waiting, no value yet
completed    → value arrived ✅
completed    → with error ❌
```

```dart
Future<User> getUser() async {
  try {
    return await api.fetchUser(); // completed with value ✅
  } catch (e) {
    throw Exception('failed');    // completed with error ❌
  }
}
```

---

### 1.3 Future.value vs Regular Future

```dart
// Regular Future → body goes to Event Queue
Future<int> regular = Future(() => 42);

// Future.value → value ready instantly, .then() goes to Microtask Queue
Future<int> immediate = Future.value(42);
```

```
Regular Future  → Event Queue     (has work to do)
Future.value    → Microtask Queue (value already ready)
```

---

### 1.4 async / await

```dart
// await pauses the function — not the app
Future<void> loadUser() async {
  final user = await api.getUser();  // pauses here
  print(user.name);                  // runs after await — Microtask Queue
}
```

---

### 1.5 await vs .then()

```dart
// .then() — callback style
api.getUser()
    .then((user) => print(user.name))
    .catchError((e) => print('error: $e'));

// await — cleaner, same result
try {
  final user = await api.getUser();
  print(user.name);
} catch (e) {
  print('error: $e');
}
```

```
await        → cleaner, readable, use always
.then()      → useful when async keyword not available
             → simple one-liners
```
// sumary: there is no difference between await and .then in implementation
---

### 1.6 Future.wait — Run in Parallel

```dart
// ❌ sequential — slow (3 seconds total)
final user    = await api.getUser();    // 1 second
final posts   = await api.getPosts();   // 1 second
final friends = await api.getFriends(); // 1 second

// ✅ parallel — fast (1 second total)
final results = await Future.wait([
  api.getUser(),
  api.getPosts(),
  api.getFriends(),
]);

final user    = results[0] as User;
final posts   = results[1] as List<Post>;
final friends = results[2] as List<User>;
```

---

### 1.7 FutureBuilder

```dart
FutureBuilder<User>(
  future: api.getUser(),    // one time fetch
  builder: (context, snapshot) {
    // snapshot states:
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }
    if (snapshot.hasData) {
      return Text(snapshot.data!.name);
    }
    return SizedBox();
  },
)
```

---

### 1.8 Completer — Create Future Manually

```dart
// useful when you need to complete a Future manually
final completer = Completer<String>();

// complete it later
completer.complete('done');        // ✅ success
completer.completeError('error');  // ❌ error

// use the future
final result = await completer.future;
```

---

### 1.9 Future Error Handling

```dart
Future<void> loadData() async {
  try {
    final data = await api.getData();
    setState(() => _data = data);
  } on DioException catch (e) {
    // handle network error
    print('network error: ${e.message}');
  } on FormatException catch (e) {
    // handle parsing error
    print('format error: ${e.message}');
  } catch (e) {
    // handle any other error
    print('unknown error: $e');
  } finally {
    // always runs
    setState(() => _loading = false);
  }
}
```

---

---

## PART 2 — STREAM

---

### 2.1 What is a Stream?

```
A Stream is a sequence of values delivered over time.
Multiple values → keep arriving → Stream stays open.
```

```dart
Stream<int> countUp() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i; // sends value, stays alive
  }
}
```

---

### 2.2 Future vs Stream

```
Future  →  one value    →  like a photo 📷
Stream  →  many values  →  like a video 🎥

Future  →  async/await
Stream  →  async*/yield or listen()
```

---

### 2.3 Stream Types

```dart
// Single subscription Stream — only ONE listener allowed
Stream<int> singleStream = Stream.fromIterable([1, 2, 3]);
singleStream.listen((v) => print(v)); // ✅ first listener
singleStream.listen((v) => print(v)); // ❌ error — already has listener

// Broadcast Stream — MULTIPLE listeners allowed
Stream<int> broadcastStream = Stream.fromIterable([1, 2, 3])
    .asBroadcastStream();
broadcastStream.listen((v) => print(v)); // ✅
broadcastStream.listen((v) => print(v)); // ✅
```

```
Single subscription  →  one listener only   →  default
Broadcast           →  many listeners       →  use .asBroadcastStream()
```

---

### 2.4 listen() — The Core Method

```dart
Stream<Message> messageStream = getMessages();

// basic listen
final subscription = messageStream.listen(
  (message) => print(message.text),  // onData — called on every value
  onError: (e) => print('error: $e'), // onError — called on error
  onDone: () => print('stream closed'), // onDone — called when stream ends
  cancelOnError: false,               // keep listening after error
);

// cancel when done — VERY IMPORTANT
subscription.cancel(); // always cancel in dispose()
```

---

### 2.5 StreamSubscription — Full Control

```dart
late StreamSubscription<Message> _subscription;

@override
void initState() {
  super.initState();
  _subscription = messageStream.listen((message) {
    if (!mounted) return;
    setState(() => _messages.add(message));
  });
}

@override
void dispose() {
  _subscription.cancel();  // ✅ always cancel in dispose
  super.dispose();
}
```

---

### 2.6 StreamController — Create Stream Manually

```dart
// single subscription controller
final controller = StreamController<String>();

// broadcast controller — multiple listeners
final controller = StreamController<String>.broadcast();

// add values to stream
controller.sink.add('hello');
controller.sink.add('world');
controller.sink.addError('something went wrong');

// listen to stream
controller.stream.listen((value) => print(value));

// close when done — IMPORTANT
controller.close();
```

---

### 2.7 StreamBuilder

```dart
StreamBuilder<List<Message>>(
  stream: getMessages(),        // live updates
  builder: (context, snapshot) {
    // snapshot states:
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }
    if (snapshot.hasData) {
      return MessageList(snapshot.data!);
    }
    return SizedBox();
  },
)
```

```
ConnectionState.none     → not connected to stream yet
ConnectionState.waiting  → connected, waiting for first value
ConnectionState.active   → receiving values
ConnectionState.done     → stream closed
```

---

### 2.8 async* and yield

```dart
// async* — function that returns a Stream
// yield  — sends a value and keeps function alive

Stream<int> countDown() async* {
  for (int i = 5; i >= 0; i--) {
    await Future.delayed(Duration(seconds: 1));
    yield i;        // sends value, stays alive
  }
}                   // stream closes naturally after loop

// usage
await for (final number in countDown()) {
  print(number);    // 5, 4, 3, 2, 1, 0
}
```

```
async  + return  →  one value   →  Future
async* + yield   →  many values →  Stream
```

---

### 2.9 Stream Transformations

```dart
Stream<int> numbers = Stream.fromIterable([1, 2, 3, 4, 5]);

// map — transform each value
numbers.map((n) => n * 2);           // 2, 4, 6, 8, 10

// where — filter values
numbers.where((n) => n % 2 == 0);    // 2, 4

// take — take first N values
numbers.take(3);                     // 1, 2, 3

// skip — skip first N values
numbers.skip(2);                     // 3, 4, 5

// distinct — remove duplicates
numbers.distinct();

// debounce — wait for pause (search field)
searchStream.debounceTime(Duration(milliseconds: 300));
```

---

### 2.10 Real World — Firebase Firestore Stream

```dart
// Firestore returns a Stream automatically
Stream<List<Message>> getMessages(String chatId) {
  return FirebaseFirestore.instance
      .collection('chats')
      .doc(chatId)
      .collection('messages')
      .orderBy('timestamp')
      .snapshots()                    // Stream<QuerySnapshot>
      .map((snap) => snap.docs
          .map((doc) => Message.fromJson(doc.data()))
          .toList());
}
```

---

### 2.11 Broadcast — Real World Use Case

```dart
// auth state changes — multiple screens listen
Stream<User?> get authStateStream =>
    FirebaseAuth.instance.authStateChanges(); // already a broadcast stream ✅

// multiple widgets can listen
authStateStream.listen((user) => print('widget 1: $user'));
authStateStream.listen((user) => print('widget 2: $user'));
```

---

### 2.12 Stream Error Handling

```dart
stream.listen(
  (data) => print(data),
  onError: (error) {
    if (error is SocketException) {
      print('no internet');
    } else {
      print('unknown error: $error');
    }
  },
  cancelOnError: false, // keep stream alive after error
);
```

---

---

## PART 3 — QUICK REFERENCE

---

### Future vs Stream — Side by Side

```
                Future              Stream
─────────────────────────────────────────────────
values          one                 many
keyword         async/await         async*/yield
builder         FutureBuilder       StreamBuilder
listen          await               .listen()
cancel          not needed          subscription.cancel()
firebase        getDocs()           snapshots()
use case        get user, login     chat, live scores, GPS
```

---

### Common Stream Mistakes

```dart
// ❌ not canceling subscription — memory leak
void initState() {
  stream.listen((v) => print(v)); // subscription ignored
}

// ✅ always store and cancel
late StreamSubscription _sub;
void initState() {
  _sub = stream.listen((v) => print(v));
}
void dispose() {
  _sub.cancel(); // ✅
  super.dispose();
}

// ❌ multiple listeners on single subscription stream
stream.listen((v) => print('1: $v'));
stream.listen((v) => print('2: $v')); // 💥 error

// ✅ use broadcast for multiple listeners
final broadcast = stream.asBroadcastStream();
broadcast.listen((v) => print('1: $v'));
broadcast.listen((v) => print('2: $v')); // ✅
```

---

### One Line Answers for Interview

```
What is a Future?
→ a promise of a single value that arrives later

What is a Stream?
→ a sequence of values delivered over time

Difference between Future and Stream?
→ Future = one value, Stream = many values over time

What is yield?
→ sends a value from async* function and keeps it alive

What is listen()?
→ subscribes to a Stream and reacts to each value

What is a broadcast Stream?
→ a Stream that allows multiple listeners simultaneously

What is StreamController?
→ manually creates and controls a Stream — add values via sink

What is StreamSubscription?
→ the object returned by listen() — used to cancel the stream

What happens if you don't cancel a StreamSubscription?
→ memory leak — stream keeps running after widget is disposed

What is the difference between async and async*?
→ async returns Future (one value), async* returns Stream (many values)

When to use FutureBuilder vs StreamBuilder?
→ FutureBuilder for one-time fetch, StreamBuilder for live data

What is Future.wait?
→ runs multiple Futures in parallel and waits for all to complete

What is a Completer?
→ manually creates and completes a Future from outside
```